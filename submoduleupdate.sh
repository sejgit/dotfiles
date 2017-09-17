#!/bin/bash
# .bashrc
# sej 2016 09 15

git pull --recurse-submodules
git submodule update --remote --recursive
gall
gcm 'update subs'
git push
