#! /bin/bash
if [ ! -d "$PERSONAL/Journal_Entries" ]; then 
    echo "no per/Journal_Entries. Abort."
    exit 1
fi

cd "$PERSONAL/Journal_Entries"

THE_DATE=$(date)
meridiem=$(echo $THE_DATE | awk '{print $6}')
case "$meridiem" in
  "PM")
    file_name=$(echo $THE_DATE | awk '{print $4"-"$3"-"$2"_"$1"_log.xml"}');;
  "AM")
    file_name=$(echo $THE_DATE | awk '{print $4"-"$3"-"($2-1)"_"$1"_log.xml"}');;
  *)
    echo "date command not working as expected" && exit 1;;
esac
touch "$file_name" &&
echo '<entry>' >> $file_name &&
echo '<sleep went="" wake="" />' >> $file_name &&
echo '<day>' >> $file_name &&
echo '</day>' >> $file_name &&
echo '</entry>' >> $file_name &&
nvim "$file_name"
cd $OLDPWD
