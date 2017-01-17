#!/bin/bash
# .bashrc
# sej 2016 03 16


# path setup
source ~/.shell/scripts/path-edit.sh
path_front ~/bin ~/.local/bin ~/.shell/scripts ~/dotfiles/git-hub/lib /usr/local/sbin /usr/local/bin
path_back /sbin /bin /usr/sbin /usr/bin ~/.local/bin/adom

export MANPATH=~/dotfiles/git-hub/man:$MANPATH

# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# run setup
source ~/.shell/scripts/run.sh

# cd options
shopt -s autocd cdspell dirspell

# glob options
shopt -s dotglob extglob globstar nocaseglob

# job options
shopt -s checkjobs huponexit

# shell options
shopt -s checkhash checkwinsize

# history options
shopt -s cmdhist histappend histverify

HISTCONTROL=ignoreboth:erasedups
HISTSIZE=2000
HISTFILESIZE=10000


# proxy settings
MYAUTH=$(<~/.ssh/myauth)
MYPROXY=$(<~/.ssh/myproxy)
export BASH_IT_HTTP_PROXY=$(printf "http://%s@%s:80" "$MYAUTH" "$MYPROXY")
export BASH_IT_HTTPS_PROXY=$(printf "http://%s@%s:80" "$MYAUTH" "$MYPROXY")
export BASH_IT_NO_PROXY=$(<~/.ssh/noproxy)
export GIT_MYAUTH=~/.ssh/myauth.git

#grep options
#export GREP_OPTIONS='--color=auto' GREP_COLORS='100;8'

# Liquid prompt only load in interactive shells
[[ $- = *i* ]] && source ~/dotfiles/liquidprompt/liquidprompt


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

