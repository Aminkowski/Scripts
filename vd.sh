#! /bin/bash
VOLLINE1=$(pactl list sinks | sed -n '/^\tV.*%/p')
VOLNUM1=$(echo "$VOLLINE1" | sed -n 's/.* \([0-9]*%\).*/\1/p')
SINK=$(pactl list sinks short | awk '{print $1}')
sh -c "pactl set-sink-mute 0 false; pactl set-sink-volume $SINK -$1%"
VOLLINE2=$(pactl list sinks | sed -n '/^\tV.*%/p')
VOLNUM2=$(echo "$VOLLINE2" | sed -n 's/.* \([0-9]*%\).*/\1/p')
echo "$SINK: $VOLNUM1 -> $VOLNUM2"
