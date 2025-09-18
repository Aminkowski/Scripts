#! /bin/bash
# make it show how many years, months, weeks, days, hours, minutes, and seconds I have left :)
# https://media.nmfn.com/tnetwork/lifespan/index.html#13 sais I'll live to ~88
# the self = all the things I take with me when I go. strive to be self-less. do all the things you need to do.
if [ "$#" -gt 1 ]; then
    echo "Too many arguments"
    exit 1
elif [ $# -eq 1 ]; then
    echo "$1"
else	# no arguments = timer
    # EPOCH="$(date +%s)"
    # DOB="$(($EPOCH + 879627600))"   # Nov 15 1997 at about 4pm est (1376 shamsi, aban, 25, 00:30) is 
    # 27 years, 10 months, 14 days and 21 hours ahead of the epoch which is
    # abou 334 months ~ 10181 days ~ 244341 hours ~ 14660460 mins ~ 879627600 seconds
    # 2808626400 seconds is 89 years
    echo "$(date --date='@879627600')"
    # echo "$( date --date='@2808566336')"
    # echo "$(date --date='@3688254000')"
    echo "$(date --date='@3688232400')"
    while true; do
	printf "%s\r" "$(date +%H:%M:%S.%N)"
	sleep 0.02
    done
fi
# while true; do printf '%s\r' "$(date)"; done
start="$(date +%s)"	# syntax: +%s distplays number of seconds since "the Epoch" = 1970-01-01 00:00 UTC
# while true; do
#     time="$(($(date +%s) - $start))"	# syntax: using arithmetic expansion to appropriately consider variables as numbers
#     printf "$time\r"
# done

