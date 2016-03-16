#!/bin/bash
# .bashrc
# sej 2016 03 14


# path setup
source ~/.shell/scripts/path-edit.sh
path_front ~/bin /usr/local/sbin /usr/local/bin ~/.shell/scripts
path_back /sbin /bin /usr/sbin /usr/bin

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

# history
shopt -s cmdhist histappend histverify

HISTCONTROL=ignoreboth
# Unset for unlimited history
HISTSIZE=
HISTFILESIZE=
# Use separate history file to avoid truncation
HISTFILE=~/.bash_history_file


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

