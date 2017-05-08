# .bash_profile
# sej 2016 03 16
# 2017 04 23 add bash_path for Darwin if exists
# 2017 05 05 move above to .bashrc


# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval $(ssh-agent)
fi


