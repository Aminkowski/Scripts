#! /bin/bash

string1="12:55:35 AM"
string2="12:17:52 PM"
string3="10:55:35 AM"
string4="04:17:52 PM"

function to24 {
    # [[ "$1" =~ ^(:digit:):(:digit:):(:digit:) AM$ ]] && echo "AM"
    if [ "${1:0-2}" = "AM" ]; then
	[ "${1:0:2}" = "12" ] && echo "00${1:2:0-3}" || echo "${1:0:0-3}"
    elif [ "${1:0-2}" = "PM" ]; then
	# [ "${1:0:2}" = "12" ] && echo "00${1:2:0-3}" || echo "${1:0-3}"
	hour=$(("${1:0:2}" + 12 ))
	[ "${1:0:2}" = "12" ] && echo "${1:0:0-3}" || echo "$hour${1:2:0-3}"
    else
	echo "false"
    fi
}


echo "$string1:$string2" | awk -F ':' '{print ($6-$3)+($5-$2)*60+($4-$1)*3600}'
to24 "$string1"
to24 "$string2"
to24 "string3"
to24 "$string3"
to24 "$string4"
# screw the ultra-generality for years
# done with hour:min:sec diff
# need to take am/pm into account
# 26 Jun 2024 01:39:09 AM EDT
