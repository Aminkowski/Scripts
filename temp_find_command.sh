#! /bin/bash
find ~ \( -path */.git -o -path ~/.cache -o -path ~/.local -o -path ~/.config -o -path ~/.mozilla \) -prune -o -cnewer /home/nima/Desktop/Personal/Journal/Oct15_primaryDraft.md
