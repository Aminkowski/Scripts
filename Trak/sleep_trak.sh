#! /bin/bash

# sleep_trak.sh duration start end date date_of_entry quality alarm 
if [[ -n "$PERSONAL" ]]; then
    TRACKDIR="$PERSONAL/Tracking";
else
    echo "PERSONAL is not set" && exit 1;
fi
file="$TRACKDIR/sleep_log.txt"

while [ "${#}" -gt 0 ]; do
    case "$1" in
        --start|-s)
            sleep_start_time=$(date -d "${2}" '+%Y/%m/%d %a %R')
            while [ $? -gt 0 ];do
                read -p "bad input for start time, try again: " Sretry
                sleep_start_time=$(date -d "${Sretry}" '+%Y/%m/%d %a %R')
            done;;
        --end|-e)
            sleep_end_time=$(date -d "${2}" '+%Y/%m/%d %a %R')
            while [ $? -gt 0 ];do
                read -p "bad input for end time, try again: " Eretry
                sleep_end_time=$(date -d "${Eretry}" '+%Y/%m/%d %a %R')
            done;;
        --duration|-d) sleep_duration="${2}" ;;
    esac
    [ $? -eq 0 ] && shift 2
done

# [ -n "$sleep_start_time" ] && [ -n "$sleep_end_time" ] && [ -z "$duration" ] && echo "find duration from dates"
# [ -n "$sleep_start_time" ] && [ -z "$sleep_end_time" ] && [ -n "$duration" ] && echo "add duration to date"
# [ -z "$sleep_start_time" ] && [ -n "$sleep_end_time" ] && [ -n "$duration" ] && echo "subtract duration from date"

# statement="at time [$(date -d 'now' '+%Y/%m/%d %a %R')]
# I logged that I slept from [$sleep_start_time]
# till [$sleep_end_time]
# for a total of $sleep_duration hours.
# The sleep was of [ ]
# quality and I woke up with|without using the alarm"

data="$(date -d 'now' '+%Y/%m/%d %a %R'), $sleep_start_time, $sleep_end_time, $sleep_duration" #, [ ], with|without"

echo "$data" >> "$file"
# a repr function
# echo "$statement put into $file"

# statement=""
# z: I slept for about 7 hours from 20:30 (2024-11-24) ish till 3:30 ish.

# the first argument will be the tag:
# getopts "z:$:w:_:+:fxj" arg
# case "${arg}" in
    # *) echo "need tag first. one of: z, $, w, _, +, f, x, j" && exit 1      # make final edit
# esac

# echo "$statement" >> "$file"
