#! /bin/bash

# 26 Jun 2024 01:39:09 AM EDT
string="26 Jun 2024 01:39:09 AM EDT"
echo "$string" | awk -v d=1 -v m=2 '{print $d $m}'

function to24 {
    if [ "${1:0-2}" = "AM" ]; then
	[ "${1:0:2}" = "12" ] && echo "00${1:2:0-3}" || echo "${1:0:0-3}"
    elif [ "${1:0-2}" = "PM" ]; then
	# [ "${1:0:2}" = "12" ] && echo "00${1:2:0-3}" || echo "${1:0-3}"
	hour=$(("${1:0:2}" + 12 ))
	[ "${1:0:2}" = "12" ] && echo "${1:0:0-3}" || echo "$hour${1:2:0-3}"
    else
	echo "MERIDIEM_error: input is not of expected format, last two characters are not indicative of Meridiem"
	exit 1
    fi
}
#need to handle what to do when first two are not hour.

echo "$string1:$string2" | awk -F ':' '{print ($6-$3)+($5-$2)*60+($4-$1)*3600}'
to24 "$string1"
to24 "$string2"
to24 "string3"
to24 "$string3"
to24 "$string4"
# screw the ultra-generality for years
# done with hour:min:sec diff
# need to take am/pm into account
