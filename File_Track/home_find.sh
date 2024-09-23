#! /bin/bash
base_dir="/home/nima"
ignore_file="home_ignore.txt"
# initializing the find command
find_command="find $base_dir \("
while IFS= read -r ignore; do
    # if [[ -d "$base_dir/$ignore" ]]; then
    if [[ -d "$ignore" ]]; then
	find_command+=" -path '$ignore' -o"
    # elif [[ -f "$base_dir/$ignore" ]]; then
    elif [[ -f "$ignore" ]]; then
	find_command+=" -wholename '$ignore' -o"
    else
	# echo "error with type of file"
	find_command+=" -wholename '$ignore' -o"
    fi
done < "$ignore_file"

# removing the trailing -o
find_command="${find_command::-2}"

# add -prune and -print to the command?
find_command+="\) -prune -o -print"

# echo "$find_command" >> "$(date | awk '{print $5}')test.txt"
eval "$find_command" >> "$(date | awk '{print $5}')test.txt"
