#!/bin/bash
# dependancies.sh
# 2016 03 23


sudo apt-get install arduino arduino-mk git emacs24 stow letsencrypt libyaml xclip tmux crawl corkscrew myrepos gpm w3m mc



ln -s ~/dotfiles/todo.txt-cli/todo.sh ~/dotfiles/shell/bin/todo.sh
ln -s ~/dotfiles/todo.txt-cli/todo_completion ~/dotfiles/shell/completions/todo_completion.sh

