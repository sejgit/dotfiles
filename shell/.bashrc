#!/bin/env bash
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

export LANG="en_US.UTF-8"
export LANGUAGE="en_US:en"

# include .bash_path if it exists
if [ -f "$HOME.bash_path" ]; then
    source "$HOME.bash_path"
fi


# OSX
if [ $(uname -s) == "Darwin" ]; then
    # Use Liquid Prompt
    source ~/dotfiles/liquidprompt/liquidprompt

    # path setup
    PATH="~/bin:~/.local/bin:~/.shell/scripts:~/dotfiles/git-hub/lib:/usr/local/sbin:$PATH"
    PATH="/usr/local/bin:/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    PATH="$PATH:/sbin:/bin:/usr/sbin:/usr/bin"
    export MANPATH="=~/dotfiles/git-hub/man:/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
    complete -C '$HOME/local/bin/eb_completion' eb
    complete -C '$HOME/local/bin/aws_completer' aws

    if ! [ $INSIDE_EMACS ]
    then
        # Add tab completion for bash completion 2
        if [ -x "$(command -v brew)" ]  &&
               [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ] ; then
            source "$(brew --prefix)/share/bash-completion/bash_completion";
            alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'
            elif [ -f /etc/bash_completion ]; then
               source /etc/bash_completion
           fi

        eval `keychain --eval --agents ssh --inherit any id_rsa`

        # for autojump
        # https://github.com/wting/autojump
        if [ -f "/usr/local/etc/profile.d/autojump.sh" ] ; then
            source "/usr/local/etc/profile.d/autojump.sh"
        fi

        # below are for GPG support & use
        export GPG_TTY=$(tty)
        if [ -n "$SSH_CONNECTION" ] ; then
            export PINENTRY_USER_DATA="USE_CURSES=1"
        fi

        if [ -f "~/.iterm2_shell_integration.bash" ] ; then
            source ~/.iterm2_shell_integration.bash
        fi

    else
        export PS1="\w> "
    fi

    # PYTHON settings for startup
    export PYTHONSTARTUP=$HOME/.pythonstartup
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/Projects
    export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
    source /usr/local/bin/virtualenvwrapper_lazy.sh
    export AUTOENV_ENABLE_LEAVE="True"
    source ~/.autoenv/activate.sh

    export ARDUINO_DIR=/Applications/Arduino.app/Contents/Java
    export ARDMK_DIR=/usr/local/opt/arduino-mk
    #export AVR_TOOLS_DIR=/Applications/Arduino.app/Contents/Resources/Java/hardware/tools/avr
    export MONITOR_PORT=/dev/tty.usbmodem1441
    export BOARD_TAG=mega
    export BOARD_SUB=atmega2560
    export ESPLIBS=$HOME/Library/Arduino15/packages/esp8266/hardware/esp8266/2.4.1/Libraries
    export ARLIBS=$HOME/Projects/sej/Arduino/libraries

    export GPG_TTY=$(tty)
    shellfiles="$HOME/.shell"
fi

if [ $(uname -s) == "Linux" ]; then
    #swap caps lock -> control
    setxkbmap -layout us -option ctrl:nocaps
    shellfiles="$HOME/.shell"
fi

if [ $(uname -o) == "Msys" ]; then
    if ! [ $INSIDE_EMACS ] ; then
        PATH="/mingw64/bin:$PATH"

	# USE ONE or NONE but NOT both of below:
	# native link simulation
	export MSYS=winsymlinks:nativestrict
	# symlink simulation on Msys
	export MSYS=winsymlinks:lnk

        # git status on PS1 prompt
        git_branch() {
            git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
        }

        export PS1="\[\e]0;\w\a\]\[\e[32m\]${HOSTNAME,,}:\[\e[33m\]\w\[\e[0m\]\[\033[35m\]\$(git_branch)\[\033[96m\]$\[\033[0m\] "

        # use xon/xoff control
        stty -ixon

    else
        export PS1="\w> "
    fi

    # tweaks
    LS_COLORS=$LS_COLORS:'di=0;37:' ; export LS_COLORS
    shellfiles="$HOME/dotfiles/shell/.shell"
    cd $HOME
fi

# If not running interactively, don't do anything
[[ $- == *i* ]] || return

#### THE FOLLOWING LINES ARE ONLY FOR INTERACTIVELY RUNNING

# Use the system config if it exists
if [ -f /etc/bashrc ]; then
    . /etc/bashrc        # --> Read /etc/bashrc, if present.
elif [ -f /etc/bash.bashrc ]; then
    . /etc/bash.bashrc   # --> Read /etc/bash.bashrc, if present.
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

# proxy settings
if [ -f ~/.ssh/myauth ] && [ -f ~/.ssh/myproxy ] && [ -f ~/.ssh/myport ] ; then
    MYAUTH=$(<~/.ssh/myauth)
    MYPROXY=$(<~/.ssh/myproxy)
    MYPORT=$(<~/.ssh/myport)
    export BASH_IT_HTTP_PROXY=$(printf "http://%s@%s:%s" "$MYAUTH" "$MYPROXY" "$MYPORT")
    export BASH_IT_HTTPS_PROXY=$(printf "http://%s@%s:%s" "$MYAUTH" "$MYPROXY" "$MYPORT")
    export BASH_IT_NO_PROXY=$(<~/.ssh/noproxy)
    export GIT_MYAUTH=~/.ssh/myauth.git
fi

# Load custom aliases, completion, plugins
for file_type in "aliases" "completions" "plugins" "scripts"
do
    CUSTOM=${shellfiles}/${file_type}/*.sh
    for config_file in $CUSTOM
    do
        if [ -e $config_file ]; then
            echo $config_file
            source $config_file
        fi
    done
done

unset config_file

# end of .bashrc
