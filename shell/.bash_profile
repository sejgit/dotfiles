#!/usr/bin/env bash
# .bash_profile

# sej 2020 03 01 init
# 2020 04 04 updates between .bashrc & .bash_profile

export LANG="en_US.UTF-8"
export LANGUAGE="en_US:en"

# Use bashrc, if installed
if [ -f .bashrc ]; then
    . .bashrc 
fi


if [[ $(uname -s) == "Darwin" ]]; then
  # OSX Brew setup
  if [[ $(uname -p) == 'arm' ]]; then
    echo M1
    export HOMEBREW_PREFIX="/opt/homebrew";
  else
    echo Intel
    export HOMEBREW_PREFIX="/usr/local";
  fi
  export  LDFLAGS="-L$HOMEBREW_PREFIX/opt/llvm/lib/c++ -Wl,-rpath,$HOMEBREW_PREFIX/opt/llvm/lib/c++"
  export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/llvm/include"
else
  export HOMEBREW_PREFIX="/usr/local" # make the path work for non-Darwin
fi

export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar";
export HOMEBREW_REPOSITORY=$HOMEBREW_PREFIX;

export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.shell/scripts:$HOME/dotfiles/git-hub/lib:$HOME/.go/bin:$HOME/perl5/bin:$HOME/node_modules:$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$HOMEBREW_PREFIX/opt/llvm/bin:$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$HOMEBREW_PREFIX/opt/go/libexec/bin:$HOMEBREW_PREFIX/opt/fzf/bin:/Library/TeX/texbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"; export PATH;

export MANPATH="/usr/share/man:$HOMEBREW_PREFIX/share/man:$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:/Library/TeX/Distributions/.DefaultTeX/Contents/Man:/opt/X11/share/man:$HOME/dotfiles/git-hub/man"; export MANPATH;

export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}";

# OSX
if [ $(uname -s) == "Darwin" ]; then
    if ! [ $INSIDE_EMACS ]; then
        # Add tab completion for bash completion 2
        if [ -x "$(command -v brew)" ] &&
               [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
            source "$(brew --prefix)/share/bash-completion/bash_completion"
            alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'
        elif [ -f /etc/bash_completion ]; then
            source /etc/bash_completion
        fi

        # for autojump
        # https://github.com/wting/autojump
        if [ -f "/usr/local/etc/profile.d/autojump.sh" ]; then
            source "/usr/local/etc/profile.d/autojump.sh"
        fi

        # below are for GPG support & use
        export GPG_TTY=$(tty)
        if [ -n "$SSH_CONNECTION" ]; then
            export PINENTRY_USER_DATA="USE_CURSES=1"
        fi

        if [ -f "~/.iterm2_shell_integration.bash" ]; then
            source ~/.iterm2_shell_integration.bash
        fi

    else
        export PS1="\w> "
    fi

    # PYTHON settings for startup
    export PYTHONSTARTUP=$HOME/.pythonstartup
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/Projects

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

    # Go development
    export GOPATH="${HOME}/.go"
    export GOROOT="$(brew --prefix golang)/libexec"
    export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
    test -d "${GOPATH}" || mkdir "${GOPATH}"
    test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"

    if [[ -d ~/.cargo ]]; then
      . "$HOME/.cargo/env"
    fi
fi


if [ $(uname -s) == "Linux" ]; then
    #swap caps lock -> control
    # setxkbmap -layout us -option ctrl:nocaps
    shellfiles="$HOME/.shell"
fi


if [ $(uname -o) == "Msys" ]; then
    if ! [ $INSIDE_EMACS ]; then
        PATH="/mingw64/bin:$PATH"

        # USE ONE or NONE but NOT both of below:
        # native link simulation
        export MSYS=winsymlinks:nativestrict
        # symlink simulation on Msys
        export MSYS=winsymlinks:lnk

        # git status on PS1 prompt
        git_branch() {
            git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
        }

        export PS1="\[\e]0;\w\a\]\[\e[32m\]${HOSTNAME,,}:\[\e[33m\]\w\[\e[0m\]\[\033[35m\]\$(git_branch)\[\033[96m\]$\[\033[0m\] "

        # use xon/xoff control
        stty -ixon

    else
        export PS1="\w> "
    fi

    # tweaks
    LS_COLORS=$LS_COLORS:'di=0;37:'
    export LS_COLORS
    shellfiles="$HOME/dotfiles/shell/.shell"
    cd $HOME
fi

if [[ $(uname -o) == "FreeBSD" ]]; then
    export PATH=$PATH:.:/usr/local/etc/udx.d/static
    export PROMPT_COMMAND='history -a'
fi

# end of .bash_profile

