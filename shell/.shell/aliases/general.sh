#!/bin/bash
# aliases/general.sh
# sej 2016 03 14


# enable ls colors
if ls --color=auto &> /dev/null; then
    alias ls="ls --color=auto"
else
    export CLICOLOR=1
fi

# uses 'thefuck' to fix common command mistakes
# https://github.com/nvbn/thefuck
alias fuck='eval $(thefuck $(fc -ln -1)); history -r'


# system dependent
if [[ $OSTYPE == darwin* ]]
then
    # power
    alias shutdown='sudo shutdown -hP now'
    alias reboot='sudo reboot now'
    alias sleep='shutdown -s now'

    # misc
    alias unlock_files='chflags -R nouchg *'
elif [[ $OSTYPE == linux-gnu ]]
then
    # power
    alias shutdown='sudo shutdown -P now'
    alias reboot='sudo shutdown -r now'
    alias halt='sudo halt -P'
fi

# miscellaneous
alias sudo='sudo ' # enable alias expansion for sudo
alias g='git'
complete -o default -o nospace -F _git g
alias make='make --debug=b'
alias ping='ping -c 8'
alias r='run'
alias root='sudo su'
alias cppc='cppcheck --std=c++11 --enable=all --suppress=missingIncludeSystem .'
alias octave='octave --quiet'
alias la='ls -a'
alias ll='ls -l'

# use emacsclient for programs opening an editor
VISUAL='e'
EDITOR="$VISUAL"

# launch emacs --daemon and a new frame
alias e='emacsclient --alternate-editor="" --create-frame'

