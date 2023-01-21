#!/usr/bin/env bash
# aliases/general.sh
# sej 2016 03 14
# 2017 03 21 updates
# 2019 10 03 format with format-all

# List directory contents
alias sl=ls
alias ls="ls -G --color=auto"
alias la='ls -AF' # Compact view, show hidden
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

if [[ $(uname -s) != "FreeBSD" ]]; then
    alias _="sudo -EH "
    alias sudo='sudo -EH ' # enable alias expansion for sudo
    alias root='sudo -EH su'
fi

alias g='git'
alias make='make --debug=b'
alias ping='_ ping -c 8'
alias r='run'
alias q='exit'
alias c='clear'
alias k='clear'
alias cls='clear'

alias edit="$EDITOR"
alias pager="$PAGER"

# alias python3='/usr/local/bin/python3'
# alias python='/usr/local/bin/python3'
# alias py='python'
# alias pip3='/usr/local/opt/python/bin/pip3'
# alias pip='/usr/local/opt/python/bin/pip3'

alias h='history'
alias my='cd My\ Documents'

# power
alias shutdown='sudo shutdown -P now'
alias reboot='sudo shutdown -r now'
alias halt='sudo halt -p'

which gshuf &>/dev/null
if [ $? -eq 0 ]; then
    alias shuf=gshuf
fi

# my other
alias crawl='crawl -dir ~/.config/.crawl -rc ~/.config/.crawl/init.txt'

pipoff() {
    export PIP_REQUIRE_VIRTUALENV=false
}

pipon() {
    export PIP_REQUIRE_VIRTUALENV=true
}
