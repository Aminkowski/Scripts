#!/bin/bash
#instead make it so that you loop through all arguments
if [ $# -ne 1 ]; then 
    echo "needs only one argument"
    exit 1
fi
# make sure it's a directory
if [ ! -d $1 ]; then 
    echo "argument should be a directory"
    exit 1
fi

for file in "$1"/*; do
	echo "$file being renamed"
	/usr/local/bin/spaces_to_underscores.sh "$file"
done
