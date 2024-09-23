#! /bin/bash
ignore_file="ignore.txt"

find_command="find / \("
while IFS= read -r ignore; do
    if [[ -d "$ignore" ]]; then
	find_command+=" -path '$ignore' -o"
    elif [[ -f "$ignore" ]]; then
	find_command+=" -wholename '$ignore' -o"
    else
	find_command+=" -wholename '$ignore' -o"
    fi
done < "$ignore_file"

# removing the trailing -o
find_command="${find_command::-2}"

find_command+="\) -prune -o -print"

eval "$find_command" >> "$(date | awk '{print $5}')test.txt"
