#!/bin/bash
# dependancies.sh
# 2016 03 23
# 2017 02 22 update


sudo apt-get install git emacs24-nox stow
git submodule foreach init
git submodule foreach sync
git submodule foreach update
