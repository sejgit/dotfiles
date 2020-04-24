#!/usr/bin/env bash
# emacs.aliases.sh
# sej 2016 03 15
# sej 2017 05 08 emacs for darwin
# sej 2018 01 28 reset to brew emacs for darwin

#set-up for darwin
#if [ $(uname -s) == "Darwin" ]; then
#    alias emacs=/Applications/Emacs.app/Contents/MacOS/Emacs
#fi

# use emacsclient for programs opening an editor
VISUAL='e'
EDITOR="$VISUAL"

alias em='emacs'
alias en='emacs -nw'
# alias e='emacsclient -n'
alias et='emacsclient -t'
alias ed='emacs --daemon'
alias E='SUDO_EDITOR=emacsclient sudo -e'

alias e='emacsclient --alternate-editor="" --create-frame'
