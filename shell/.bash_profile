#!/bin/env bash
# .bash_profile

# sej 2016 03 16
# 2017 04 23 add bash_path for Darwin if exists
# 2017 05 05 move above to .bashrc
# 2017 09 06 add keychain
# 2017 11 21 add INSIDE_EMACS test
# 2018 10 26 add for GPG
# 2018 10 28 add for autojump
# 2019 05 20 clean-up & add Msys

# some fun
if [ -x "$(command -v archey)" ] ; then
    archey -c
fi

# include .bashrc if it exists
if [ -f "$HOME.bashrc" ]; then
    source "$HOME.bashrc"
fi

if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval $(ssh-agent)
fi

# end of .bash_profile
