#!/usr/bin/env zsh
# .zlogin for use on osx and linux
# 2022-09-21 init sej

#echo ".zlogin"

[[ $TERM == "dumb" || $TERM == "tramp" ]] && unsetopt zle && PS1='$ ' && return

# set up screenfetch
if [[ $(uname -s) == "Darwin" ]]; then
    if command -v screenfetch 1>/dev/null 2>&1; then
        screenfetch -D 'Mac OS x'
    else
        echo "screenfetch needs to be installed for splashscreen: brew install screenfetch"
    fi
else
    if command -v screenfetch 1>/dev/null 2>&1; then
        screenfetch
    else
        echo "screenfetch needs to be installed for splashscreen.  Use appropriate package manager."
    fi
fi

