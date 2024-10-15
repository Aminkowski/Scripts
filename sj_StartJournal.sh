#! /bin/bash
if [ ! -d "$PERSONAL/Journal" ]; then 
    echo "no per/Journal. Abort."
    exit 1
fi

cd "$PERSONAL/Journal"

THE_DATE=$(date)
meridiem=$(echo $THE_DATE | awk '{print $6}')
case "$meridiem" in
  "PM")
    file_name=$(echo $THE_DATE | awk '{print $3 $2"_primaryDraft.md"}');;
  "AM")
    file_name=$(echo $THE_DATE | awk '{print $3 ($2-1)"_primaryDraft.md"}');;
  *)
    echo "date command not working as expected" && exit 1;;
esac

if [ -f "$PERSONAL/Journal/$file_name" ]; then 
    echo "File already exists. Editing..."
    nvim "$file_name"
    exit 0
fi

touch "$file_name" &&
echo '# Most Important Things:' >> $file_name &&
echo '- [ ] ' >> $file_name &&
echo '- [ ] ' >> $file_name &&
echo '- [ ] ' >> $file_name &&
echo '### Greatest Time Sinks:' >> $file_name &&
echo '### Events:' >> $file_name &&
echo '### Add to TaskList:' >> $file_name &&
echo '### Time Wasters:' >> $file_name &&
echo '### What I ate:' >> $file_name &&
echo '### Exercise:' >> $file_name &&
echo '### Meditation:' >> $file_name &&
echo '##### Hygiene: Shower [ ] Shampoo [ ]  Brow [ ]  Cheeks [ ]  Beard [ ] Floss [ ] Calluses [ ] Nails [ ]' >> $file_name &&
echo '### Finances:' >> $file_name &&
echo '### Files:' >> $file_name &&
echo '### Thoughts:' >> $file_name &&
nvim "$file_name"
cd $OLDPWD
