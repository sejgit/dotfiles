#!/usr/bin/env bash
# .bashrc

# sej 2016 03 16 init
# 2017 05 05 move to mac updates
# 2017 05 10 added python setups
# 2017 09 06 added pass for darwin
# 2017 09 11 add en_US.UTF-8
# 2017 12 11 modify python portion
# 2018 02 08 add some completions for darwin aws
# 2018 04 22 add variables for arduino-mk
# 2019 05 20 clean-up & add Msys stuff
# 2019 05 23 add winsymlinks
# 2019 10 04 reformat with all-format
# 2020 04 04 updates between .bashrc & .bash_profile

# Use bash_profile, if installed
if [ -f .bash_profile ]; then
    . bash_profile
fi

# Use Bash completion, if installed
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# history options
shopt -s cmdhist histappend histverify

HISTCONTROL=ignoreboth:erasedups
HISTSIZE=5000
HISTFILESIZE=10000

# Load custom aliases, completion, plugins
for file_type in "aliases" "completions" "plugins" "scripts"; do
    CUSTOM=${shellfiles}/${file_type}/*.sh
    for config_file in $CUSTOM; do
        if [ -e $config_file ]; then
            echo $config_file
            source $config_file
        fi
    done
done

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# end of .bashrc
