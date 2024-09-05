#! /bin/bash
eval $(ssh-agent)
ssh-add
cd $PERSONAL
git fetch
git diff --stat
git add .
git commit -m "routine sync via script"
git push
cd $OLDPWD
cd $MY_DOTFILES
git fetch
git diff --stat
git add .
git commit -m "routine sync via script"
git push
cd $OLDPWD
cd "$CODESPACE/Scripts"
git fetch
git diff --stat
git add .
git commit -m "routine sync via script"
git push
cd $OLDPWD
