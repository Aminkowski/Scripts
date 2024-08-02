#!/bin/bash
if [ $# -ne 1 ]; then 
    echo "needs only one argument"
    exit 1
fi

name=$1
rename=$(echo $name | sed 's/ /_/g')
# if unchanged just exit. In case of dirs avoids errors.
[ "$name" = "$rename" ] && echo "contains no spaces" && exit 0
# also add other annoying characters, like {} and []. 

# Checking:
#echo "renaming $name to $rename"
mv "$name" "$rename"
