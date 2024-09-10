#! /bin/bash
#cd $PERSONAL
file_name=$(date | awk '{print $4"-"$3"-"$2"_"$1"_log.txt"}')
touch "$file_name" &&
echo "Time of sleep on the night before: " >> $file_name &&
echo "Waking time today: " >> $file_name &&
echo "things done begin:" >> $file_name &&
echo "things done end." >> $file_name &&
nvim "$file_name"
