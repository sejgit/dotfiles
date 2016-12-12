#!/bin/bash
# emacs.aliases.sh
# sej 2016 03 15


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
