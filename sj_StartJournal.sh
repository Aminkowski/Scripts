#! /bin/bash
if [ ! -d "$PERSONAL/Journal" ]; then 
    echo "no per/Journal. Abort."
    exit 1
fi

function template {
  touch "$1" &&
  cat <<EOF > "$1"
# Notes

# Checklists:
## Dailies:
### 心
- [ ] Meditate
- [ ] Journal
- [ ] Fujingo
### 技
- [ ] Anki
- [ ] an hour of work (off-hours)
- [ ] Apply to jobs for an hour
### 体
- [ ] Sleep 8 hours
- [ ] Don't eat after 6
- [ ] Do some exercise: Grip

## Weeklies:
- [ ] Anki Week in Review: 
- [ ] An hour of clearing: 

<!-- ## Archives: -->
<!-- ### Dailies: -->
<!-- Log Dreams -->
<!-- Typing Practice -->
<!-- Work on Project Portfolio -->
<!-- Track Time Spent -->
<!-- Track Calories -->
<!-- Track Finances -->
<!-- Make 3 goals for tomorrow -->
<!-- Shower / Hair care -->
<!-- Skincare -->
<!-- Shave -->
<!-- Floss -->
<!-- ### Weeklies: -->
<!-- Socialize: -->
<!-- Brows -->
<!-- Clip Nails -->
<!-- Trim -->
EOF
  nvim "$1"
  # echo '### Files:' >> $file_name &&
  # find ~ \( -path */.git -o -path ~/.cache -o -path ~/.local -o -path ~/.config -o -path ~/.mozilla \) -prune -o -newerct "$(date -d '-1 day' '+%Y/%m/%d 6:00:00')" >> $file_name &&
}

if [ $# -gt 0 ];
then
  file_name=$(date -d '-1 day' '+%m-%d_journal.md')    # Yesterday's date
else
  file_name=$(date '+%m-%d_journal.md')    # Today's date
fi

pushd "$PERSONAL/Journal"

if [ -f "$file_name" ]; then
    echo "File already exists. Editing..."
    nvim "$file_name"
    exit 0
else
  template "$file_name"
fi

popd
