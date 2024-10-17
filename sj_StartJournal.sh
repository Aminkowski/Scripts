#! /bin/bash
if [ ! -d "$PERSONAL/Journal" ]; then 
    echo "no per/Journal. Abort."
    exit 1
fi

if [ $# -gt 0 ];
then
  file_name=$(date -d '-1 day' '+%Y-%m-%d_journal.md')
else
  file_name=$(date '+%Y-%m-%d_journal.md')
fi

cd "$PERSONAL/Journal"

if [ -f "$file_name" ]; then 
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
