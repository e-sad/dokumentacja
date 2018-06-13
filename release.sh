#!/bin/bash
# File: release.sh
# (c) 2018 Paweł 'felixd' Wojciechowski
# Outsourcing IT - Konopnickiej.Com
# Source: https://gitlab.com/felixd/git-releaser

if [ -d "git-releaser/" ]; then
 git-releaser/git-releaser.sh
else

 git clone https://gitlab.com/felixd/git-releaser.git

 if [ -f "release.sh" ]; then
  echo "Giving execution attributes to: release.sh"
  chmod +x release.sh
 fi

 echo "Checking if .gitignore ignores [git-releaser/] folder"
 if [ ! -f ".gitignore" ]; then
   echo ".gitignore does not exist. Creating it + ignoring git-releaser/ folder."
   echo "git-releaser/" >> .gitignore
 else
   if grep -R "git-releaser/" .gitignore; then
     echo "It already ignores it. No need to change anything."
   else
     echo "File exists but does not ignore [git-releaser/]. Changing that."
     echo "git-releaser/" >> .gitignore
   fi
 fi

 if [ ! -f "VERSION" ]; then
   echo "Creating VERSION file"
   echo "0.0.0" > VERSION
 fi

fi
