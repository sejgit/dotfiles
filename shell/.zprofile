#!/usr/bin/env zsh
# .zprofile for use on osx & maybe others later
# 2020-03-01 init sej
# 2020-04-04 updates between .zshrc & .zshenv & .zprofile

# Emacs term solution
[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return

# set vars
export LANG="en_US.UTF-8"
export LANGUAGE="en_US:en"

# below are for GPG support & use
export GPG_TTY=$(tty)
if [[ -n "$SSH_CONNECTION" ]]
then
    export PINENTRY_USER_DATA="USE_CURSES=1"
fi
export GPG_TTY=$(tty)


if [[ $(uname -s) == "Darwin" ]]
then
    # Arduino setup
    export ARDUINO_DIR=/Applications/Arduino.app/Contents/Java
    export ARDMK_DIR=/usr/local/opt/arduino-mk
    #export AVR_TOOLS_DIR=/Applications/Arduino.app/Contents/Resources/Java/hardware/tools/avr
    export MONITOR_PORT=/dev/tty.usbmodem1441
    export BOARD_TAG=mega
    export BOARD_SUB=atmega2560
    export ESPLIBS=$HOME/Library/Arduino15/packages/esp8266/hardware/esp8266/2.4.1/Libraries
    export ARLIBS=$HOME/Projects/sej/Arduino/libraries

    # Go development
    export GOPATH="${HOME}/.go"
    export GOROOT="$(brew --prefix golang)/libexec"
    # export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"  # see below
    test -d "${GOPATH}" || mkdir "${GOPATH}"
    test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"

    # micropython development
    export MICROPYTHON=${HOME}/Projects/micropython/ctng-volume
    export ESPIDF=${MICROPYTHON}/esp-idf
fi


# end of .zprofile
