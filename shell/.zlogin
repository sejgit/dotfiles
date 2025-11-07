#!/usr/bin/env zsh
# .zlogin for use on osx and linux
# 2022-09-21 init sej
# <2024-06-30 Sun> set for tramp

#printf ".zlogin\n"

# for Emacs tramp
[[ $TERM == "dumb" || $TERM == "tramp" ]] && unsetopt zle && PS1='$ ' && return

# set up screenfetch
if [[ $(uname -s) == "Darwin" ]]; then
    if command -v fastfetch 1>/dev/null 2>&1; then
        fastfetch
    else
        printf "fastfetch needs to be installed for splashscreen: brew install fastfetch\n"
    fi
else
    if command -v fastfetch 1>/dev/null 2>&1; then
        fastfetch
    else
        printf "fastfetch needs to be installed for splashscreen.  Use appropriate package manager\n"
    fi
fi

