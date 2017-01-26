#!/bin/bash
# Copyright: Pawel 'felixd' Wojciechowski - Outsourcing IT - Konopnickiej.Com
# Year: 2017

if [ -d "git-releaser/" ]; then
 git-releaser/git-releaser.sh
else
 git clone https://github.com/felixd/git-releaser/
fi
