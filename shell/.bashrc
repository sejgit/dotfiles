#!/bin/bash
# .bashrc
# sej 2016 03 16
# 2017 05 05 move to mac updates
# 2017 05 10 added python setups
# 2017 09 06 added pass for darwin
# 2017 09 11 add en_US.UTF-8

export LANG="en_US.UTF-8"
export LANGUAGE="en_US:en"

# path setup
if [ $(uname -s) == "Darwin" ]; then
    # for pass and Emacs pass
    source /usr/local/etc/bash_completion.d/password-store
    # include .bash_path if it exists
    if [ -f "$HOME/.bash_path" ]; then
	. "$HOME/.bash_path"
    fi
    source ~/.iterm2_shell_integration.`basename $SHELL`
fi
source ~/.shell/scripts/path-edit.sh
path_front ~/bin ~/.local/bin ~/.shell/scripts ~/dotfiles/git-hub/lib /usr/local/sbin /usr/local/bin
path_back /sbin /bin /usr/sbin /usr/bin ~/.local/bin/adom

export MANPATH=~/dotfiles/git-hub/man:$MANPATH

# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# run setup
source ~/.shell/scripts/run.sh

# history options
shopt -s cmdhist histappend histverify

HISTCONTROL=ignoreboth:erasedups
HISTSIZE=2000
HISTFILESIZE=10000

if [ $(uname -s) == "Linux" ]; then
    #swap caps lock -> control
    setxkbmap -layout us -option ctrl:nocaps
fi

# # proxy settings
# MYAUTH=$(<~/.ssh/myauth)
# MYPROXY=$(<~/.ssh/myproxy)
# export BASH_IT_HTTP_PROXY=$(printf "http://%s@%s:80" "$MYAUTH" "$MYPROXY")
# export BASH_IT_HTTPS_PROXY=$(printf "http://%s@%s:80" "$MYAUTH" "$MYPROXY")
# export BASH_IT_NO_PROXY=$(<~/.ssh/noproxy)
# export GIT_MYAUTH=~/.ssh/myauth.git

# Liquid prompt only load in interactive shells
[[ $- = *i* ]] && source ~/dotfiles/liquidprompt/liquidprompt

# PYTHON settings for virtualenv protection 
gpip(){
    PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

gpip3(){
    PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}

# PYTHON settings for startup
export PYTHONSTARTUP=$HOME/.pythonstartup


# Load custom aliases, completion, plugins
for file_type in "aliases" "completions" "plugins"
do
    CUSTOM=~/.shell/${file_type}/*.sh
    for config_file in $CUSTOM
    do
	if [ -e $config_file ]; then
	    echo $config_file
	    source $config_file
        fi
    done
done

unset config_file



