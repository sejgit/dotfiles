# .bash_profile
# sej 2016 03 16
# 2017 05 23 add bash_path for Darwin if exists

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

if [ $(uname -s) == "Darwin" ]; then
    # include .bash_path if it exists
    if [ -f "$HOME/.bash_path" ]; then
	. "$HOME/.bash_path"
    fi
fi

if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval $(ssh-agent)
fi

