#! /bin/bash

# I just want this to read the activities of a journal entry.
# for today I'll try it with just text editing / bash rather than any very helpful libraries which magically do it for me.

[ ! -f $1 ] && echo "entry doesn't exist, exiting." && exit 1

text=$(cat $1)
activities=""
for line in "$text"; do
    temp=$(echo "$line" |
	grep -e "title" -e "activity" |
	sed 's/.*\(title\|activity\)=\"//' |
	sed 's/\".*//')
    activities="$activities\n$temp"
done
printf "$activities" | sort | uniq #| wc -l
