#! /bin/bash
if [ ! -d "$PERSONAL/Journal" ]; then 
    echo "no per/Journal. Abort."
    exit 1
fi

yesterday=$(date -d '-1 day' '+%Y-%m-%d_journal.md')
today=$(date '+%Y-%m-%d_journal.md')
if [ $# -gt 0 ];
then
  file_name=$yesterday
else
  file_name=$today
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
echo '### Dream:' >> $file_name &&
echo '##### Hygiene: Shower [ ] Shampoo [ ]  Brow [ ]  Cheeks [ ]  Moisturizer [ ] Beard [ ] Floss [ ] Teeth { } { } Calluses [ ] Nails [ ] Trimming { } { } ' >> $file_name &&
echo '### Finances:' >> $file_name &&
echo '### Files:' >> $file_name &&
find ~ \( -path */.git -o -path ~/.cache -o -path ~/.local -o -path ~/.config -o -path ~/.mozilla \) -prune -o -newerct "$(date -d '-1 day' '%Y/%m/%d 6:00:00')" >> $file_name &&
echo '### Thoughts:' >> $file_name &&
nvim "$file_name"
cd $OLDPWD
