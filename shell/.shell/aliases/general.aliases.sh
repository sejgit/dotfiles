#!/bin/bash
# aliases/general.sh
# sej 2016 03 14

# List directory contents
alias sl=ls
alias ls='ls -G'        # Compact view, show colors
alias la='ls -AF'       # Compact view, show hidden
alias ll='ls -al'
alias l='ls -a'
alias l1='ls -1'

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
#alias -- -="cd -"

alias _="sudo -E "
alias sudo='sudo -E ' # enable alias expansion for sudo
alias root='sudo -E su'
alias g='git'
alias make='make --debug=b'
alias ping='ping -c 8'
alias r='run'
alias q='exit'
alias c='clear'
alias k='clear'
alias cls='clear'

alias edit="$EDITOR"
alias pager="$PAGER"

# Language aliases
alias rb='ruby'
alias py='python'
alias ipy='ipython'
alias irc="$IRC_CLIENT"

# power
alias shutdown='sudo shutdown -P now'
alias reboot='sudo shutdown -r now'
alias halt='sudo halt -p'


if [ $(uname) = "Linux" ]
then
  alias ls="ls --color=auto"
fi
which gshuf &> /dev/null
if [ $? -eq 0 ]
then
  alias shuf=gshuf
fi

# my other
alias crawl='crawl -dir ~/.config/.crawl -rc ~/.config/.crawl/init.txt'


