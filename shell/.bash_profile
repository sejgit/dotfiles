# .bash_profile
# sej 2016 03 16

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval $(ssh-agent)
    ssh-add
fi

