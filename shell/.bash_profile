# .bash_profile
# sej 2016 03 16
# 2017 04 23 add bash_path for Darwin if exists
# 2017 05 05 move above to .bashrc
# 2017 09 06 add keychain
# 2017 11 21 add INSIDE_EMACS test
# 2018 10 26 add for GPG
# 2018 10 28 add for autojump

# if running bash
if ! [ $INSIDE_EMACS ]
then
    if [ -n "$BASH_VERSION" ]; then
	# Add tab completion for bash completion 2
	if which brew > /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	    source "$(brew --prefix)/share/bash-completion/bash_completion";
	elif [ -f /etc/bash_completion ]; then
	    source /etc/bash_completion;
	fi;    # include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
	    . "$HOME/.bashrc"
	fi
    fi

    if [ -z "$SSH_AUTH_SOCK" ] ; then
	eval $(ssh-agent)
    fi

    eval `keychain --eval --agents ssh --inherit any id_rsa`

    test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# below are for GPG support & use
    export GPG_TTY=$(tty)
    if [[ -n "$SSH_CONNECTION" ]]; then
        export PINENTRY_USER_DATA="USE_CURSES=1"
    fi

    # for autojump
    # https://github.com/wting/autojump
    [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
fi
