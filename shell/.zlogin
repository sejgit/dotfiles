#!/usr/bin/env zsh
# .zlogin for use on osx and linux
# 2022-09-21 init sej
# <2024-06-30 Sun> set for tramp

#printf ".zlogin\n"

# for Emacs tramp
[[ $TERM == "dumb" || $TERM == "tramp" ]] && unsetopt zle && PS1='$ ' && return

# set up screenfetch
if [[ $(uname -s) == "Darwin" ]]; then
    if command -v screenfetch 1>/dev/null 2>&1; then
        screenfetch -D 'Mac OS x'
    else
        printf "screenfetch needs to be installed for splashscreen: brew install screenfetch\n"
    fi
else
    if command -v screenfetch 1>/dev/null 2>&1; then
        screenfetch
    else
        printf "screenfetch needs to be installed for splashscreen.  Use appropriate package manager\n"
    fi
fi

