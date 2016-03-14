#!/bin/bash
# settings/generalsettings
# sej 2016 03 14

# path setup
source ~/.shell/other/path-edit.sh
path_front ~/bin /usr/local/sbin /usr/local/bin
path_back /sbin /bin /usr/sbin /usr/bin

# run setup
source ~/.shell/other/run.sh

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

