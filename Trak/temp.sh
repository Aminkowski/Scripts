#! /bin/bash

# criteria:
# I/O: one addition per command
# storage
# sleep, food, exercise, soc,   # tips, todos, goals, recurrents,   # journal, entertainment,   # scopes, finance, work, supplemens
    # don't include a misc / generic / other category. remember the point is not to track 100% but to track what matters 100%
    # values > goals > todos
# optional args
#   start time, end time
# different files
# add date of doing

# scope: [..] vs [[..]], ${..} vs $.., goals vs values vs .... stuff, else statement one-liner, modularize later
# anki: optargs, 
# wasted too much time reading getopts man page
# make doc appointment for general and sti checkup
# arrange winter clothes, take out fall clothes
# wax balls

_Exercises() {
cat << EOF
Push:
11) Push-ups, 12) Pike Push-ups, 13) Handstands, 14) Weighted Push-ups, 15) 1-arm Push-ups,
16) Dips, 17) Bench Dips,
21) Bench Press, 22) Shoulder Press, 23) Skull-Crushers, 24) Tricep Kick-backs

Pull:
Pull-ups, 

Legs:
...
EOF
}

# files go here
if [[ -n "$PERSONAL" ]]; then
    TRACKDIR="$PERSONAL/Tracking";
else
    echo "PERSONAL is not set" && exit 1;
fi

# statement=""
# z: I slept for about 7 hours from 20:30 (2024-11-24) ish till 3:30 ish.

# the first argument will be the tag:
getopts "z:$:w:_:+:fxj" arg
case "${arg}" in
    z) file="$TRACKDIR/sleep_log.txt"
        statement="I slept for about $OPTARG hours, ";;
    $) file="$TRACKDIR/finance_log.txt" ;;
    w) file="$TRACKDIR/work_log.txt" ;;
    _) file="$TRACKDIR/unter_log.txt" ;;
    +) file="$TRACKDIR/uber_log.txt" ;;
    f) file="$TRACKDIR/food_log.txt" ;;
    x) file="$TRACKDIR/exercise_log.txt"
        _Exercises;;
    j) sj_StartJournal.sh && exit 0 || echo "sj not defined for some reason" && exit 1 ;;
    *) echo "need tag first. one of: z, $, w, _, +, f, x, j" && exit 1      # make final edit
esac
echo $OPTIND
shift "$(( $OPTIND -1 ))"   # shifting to the next argument
[[ -n "$OPTARG" ]] && duration="$OPTARG" && echo "duration set to $OPTARG"
echo $OPTERR
# z: sleep + duration
# $: money / finances + value
# w: work + hours on clock
# _: for checking off tasks from tasks list (have option of picking / autofilling) + kwargs
# +: time wasters + duration. things like youtube, anime, tv, pr0n, **without social justification** also use other args to write name of poison
# f: food (use kwargs)
# x: exercise (use kwargs)
# j: opens a journal, similar to sj rn
#
# s  
# s 
# s supplements. use cron
# add these to to corresponding list:
# t 
# t 
# g: goals (each requires a corresponding task)
# r: recurrents (each is a task, task list gets synced with this, utilize cron, maybe values)

while [[ "${#}" -gt 0 ]]; do    # going through args
    case "${1}" in
        +d) echo "duration";;
        +start) echo "duration";;
        +end) echo "duration";;
        # Exercise ===
    esac
    echo "the first non-tag related argument is ${1}"
    shift
done

# if duration is set and start-time is set then want to be able to omit end-time and still get the full duration

echo "$statement" >> "$file"
# exercise: duration, start / end time, the name of the exercise, associated muscle groups, number of sets, number of reps per set, weight (if applicable) / other difficulty metric (eg: angle, duration of hold, ...), link?
