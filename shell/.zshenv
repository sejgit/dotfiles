#!/bin/env zsh
# .zshenv for use on osx & maybe others later
# 2020-03-01 init sej


emulate -LR zsh # reset zsh options

# set vars
export LANG="en_US.UTF-8"
export LANGUAGE="en_US:en"
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=5000
HISTSIZE=2000


# set options
setopt AUTO_CD
setopt NO_CASE_GLOB
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt CORRECT
setopt CORRECT_ALL

# path setup
export PATH=/usr/local/opt/coreutils/libexec/gnubin:/usr/bin:/bin:/usr/sbin:/sbin:~/bin:~/.local/bin:~/.shell/scripts:~/dotfiles/git-hub/lib:/usr/local/sbin:/usr/local/bin:$PATH
export MANPATH="=~/dotfiles/git-hub/man:/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

fpath=(~/.zsh $fpath)

# below are for GPG support & use
export GPG_TTY=$(tty)
if [[ -n "$SSH_CONNECTION" ]]
then
    export PINENTRY_USER_DATA="USE_CURSES=1"
fi
export GPG_TTY=$(tty)


# Arduino setup
export ARDUINO_DIR=/Applications/Arduino.app/Contents/Java
export ARDMK_DIR=/usr/local/opt/arduino-mk
#export AVR_TOOLS_DIR=/Applications/Arduino.app/Contents/Resources/Java/hardware/tools/avr
export MONITOR_PORT=/dev/tty.usbmodem1441
export BOARD_TAG=mega
export BOARD_SUB=atmega2560
export ESPLIBS=$HOME/Library/Arduino15/packages/esp8266/hardware/esp8266/2.4.1/Libraries
export ARLIBS=$HOME/Projects/sej/Arduino/libraries


# proxy settings
if [[ -f ~/.ssh/myauth ]] && [[ -f ~/.ssh/myproxy ]] && [[ -f ~/.ssh/myport ]]
then
    MYAUTH=$(<~/.ssh/myauth)
    MYPROXY=$(<~/.ssh/myproxy)
    MYPORT=$(<~/.ssh/myport)
    export BASH_IT_HTTP_PROXY=$(printf "http://%s@%s:%s" "$MYAUTH" "$MYPROXY" "$MYPORT")
    export BASH_IT_HTTPS_PROXY=$(printf "http://%s@%s:%s" "$MYAUTH" "$MYPROXY" "$MYPORT")
    export BASH_IT_NO_PROXY=$(<~/.ssh/noproxy)
    export GIT_MYAUTH=~/.ssh/myauth.git
fi

# Go development
export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"


# end of .zshrc
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
