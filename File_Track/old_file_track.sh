#!/bin/bash

# Assuming all files I want to manage are in ~
LIMITED_TO="~"

# Directories to be pruned:
#PRUNED=(~/.cache ~/.local ~/.config)
# all of these are in ~
PRUNE_FILE="/home/nima/Desktop/Coding/Scripts/ignore_these_directories.sh"
PRUNE_EXPR=""
# the venvs are also to be ignored as well
VENVS_EXPR1="-path ~/Desktop/Coding/PythonVenvs -prune -o"
VENVS_EXPR2="-path ~/Desktop/Coding/.venvs -prune -o"
PRUNE_EXPR="$VENVS_EXPR1 $VENVS_EXPR2"
#for dir in "${PRUNED[@]}"; do
for dir in $(cat $PRUNE_FILE | sed "s/#.*// ; /^$/ d ; sZ^Z~/Z"); do
    PRUNE_EXPR="$PRUNE_EXPR -path $dir -prune -o"
done
#PRUNE_EXPR="${PRUNE_EXPR::-3}"
# prune anything in a .git
PRUNE_EXPR="$PRUNE_EXPR -path '*/.git' -prune -o "

# The command
#eval "find $LIMITED_TO \( $PRUNE_EXPR \) -name '*'"
eval "find $LIMITED_TO $PRUNE_EXPR -print"
#echo "find $LIMITED_TO $PRUNE_EXPR -print"
