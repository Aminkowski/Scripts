#! /bin/bash

# add flags later (yesterday, other date, etc.)
# data stuff (avg, var, momenta), total
# warn if adding twice on same day, ask if want to replace or correct yesterday's

read -p "Time (in seconds): " time

if [[ "$time" =~ ^\d+$ ]]; then
    echo "Error: time must be a number (seconds)." >&2
    exit 1
fi

if [ ! -f "$PERSONAL/Tracking/plank_log.csv" ]; then
    echo "Personal/Tracking/plank_log.csv DNE!" >&2
    exit 1
fi

last_time=$(tail -n1 "$PERSONAL/Tracking/plank_log.csv" | awk -F"," '{print $2}')
[ "$time" -gt "$last_time" ] && echo "Better than yesterday 💪" || echo "🥲"

plankdate=$(date '+%F')
echo "$plankdate,$time" >> "$PERSONAL/Tracking/plank_log.csv"
echo "Added: $plankdate,$time"
