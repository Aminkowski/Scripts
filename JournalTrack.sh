#!/usr/bin/bash
# journal_tracker.sh
# Usage: ./journal_tracker.sh [path/to/YYYY-MM-DD.md]
# If no file given, looks for today's journal in the current directory.

set -euo pipefail	# no idea what this does

STREAK_FILE="${STREAK_FILE:-$(dirname "$0")/streaks.json}"	# no idea what this does

# ── resolve journal file ────────────────────────────────────────────────────
if [[ $# -ge 1 ]]; then
  JOURNAL="$1"
else
  JOURNAL="$(date +%F).md"
fi

if [[ ! -f "$JOURNAL" ]]; then
  echo "❌  Journal file not found: $JOURNAL"
  exit 1
fi

DATE=$(basename "$JOURNAL" .md)   # e.g. 2026-03-31

# ── parse checklist items ───────────────────────────────────────────────────
declare -A STATUS   # item_name -> x | - | ~ | ' '

while IFS= read -r line; do
  if [[ "$line" =~ ^[-*]\ \[([x~\ -])\]\ (.+)$ ]]; then
    mark="${BASH_REMATCH[1]}"
    # grab label up to any trailing colon+space content (e.g. "Anki Week in Review: stuff")
    label=$(echo "${BASH_REMATCH[2]}" | sed 's/[[:space:]]*:[[:space:]].*$//' | xargs)
    STATUS["$label"]="$mark"
  fi
done < "$JOURNAL"

# ── display today's results ─────────────────────────────────────────────────
echo ""
echo "📓  Journal: $DATE"
echo "────────────────────────────"

total=0; done_count=0; partial=0; skipped=0; untouched=0

for item in "${!STATUS[@]}"; do
  mark="${STATUS[$item]}"
  ((total++))
  case "$mark" in
    x)   symbol="✅"; ((done_count++)) ;;
    "~") symbol="〰️ "; ((partial++)) ;;
    "-") symbol="❌"; ((skipped++)) ;;
    " ") symbol="⬜"; ((untouched++)) ;;
    *)   symbol="❓" ;;
  esac
  printf "  %s  %s\n" "$symbol" "$item"
done | sort

echo "────────────────────────────"
printf "  ✅ %d  〰️  %d  ❌ %d  ⬜ %d  (of %d)\n" \
  "$done_count" "$partial" "$skipped" "$untouched" "$total"

# ── load or init streaks.json ───────────────────────────────────────────────
if [[ ! -f "$STREAK_FILE" ]]; then
  echo '{}' > "$STREAK_FILE"
fi

# requires jq
if ! command -v jq &>/dev/null; then
  echo ""
  echo "⚠️  jq not found — skipping streak tracking. Install with: brew install jq"
  exit 0
fi

json=$(cat "$STREAK_FILE")

# ── update streaks for each item ───────────────────────────────────────────
for item in "${!STATUS[@]}"; do
  mark="${STATUS[$item]}"
  key=$(echo "$item" | tr ' ' '_' | tr -cd '[:alnum:]_')

  last_date=$(echo "$json" | jq -r --arg k "$key" '.[$k].last_date // ""')
  streak=$(echo "$json"    | jq -r --arg k "$key" '.[$k].streak    // 0')
  best=$(echo "$json"      | jq -r --arg k "$key" '.[$k].best      // 0')

  # calculate yesterday relative to journal date
  yesterday=$(date -d "$DATE - 1 day" +%F 2>/dev/null \
    || date -v-1d -j -f "%Y-%m-%d" "$DATE" +%F)  # macOS fallback

  if [[ "$mark" == "x" ]]; then
    if [[ "$last_date" == "$yesterday" || "$last_date" == "$DATE" ]]; then
      [[ "$last_date" != "$DATE" ]] && ((streak++)) || true
    else
      streak=1
    fi
    [[ "$streak" -gt "$best" ]] && best="$streak"
    json=$(echo "$json" | jq \
      --arg k "$key" --arg d "$DATE" --argjson s "$streak" --argjson b "$best" \
      '.[$k] = {last_date: $d, streak: $s, best: $b}')
  fi
done

echo "$json" | jq '.' > "$STREAK_FILE"

# ── display streaks ─────────────────────────────────────────────────────────
echo ""
echo "🔥  Streaks (completed days in a row)"
echo "────────────────────────────"

for item in "${!STATUS[@]}"; do
  [[ "${STATUS[$item]}" != "x" ]] && continue
  key=$(echo "$item" | tr ' ' '_' | tr -cd '[:alnum:]_')
  streak=$(echo "$json" | jq -r --arg k "$key" '.[$k].streak // 0')
  best=$(echo "$json"   | jq -r --arg k "$key" '.[$k].best   // 0')
  printf "  🔥 %-30s  streak: %s  (best: %s)\n" "$item" "$streak" "$best"
done | sort

echo ""
