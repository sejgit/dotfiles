#!/usr/bin/env zsh
# .zprofile for use on osx & maybe others later
# 2020-03-01 init sej
# 2020-04-04 updates between .zshrc & .zshenv & .zprofile

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
    # export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
    test -d "${GOPATH}" || mkdir "${GOPATH}"
    test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"

    # micropython development
    export MICROPYTHON=${HOME}/Projects/micropython/ctng-volume
    export ESPIDF=${MICROPYTHON}/esp-idf
fi


# path setup
export PATH="${HOME}/bin:${HOME}/.local/bin:${HOME}/.shell/scripts:${HOME}/dotfiles/git-hub/lib:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:/Library/TeX/texbin:/opt/X11/bin:$PATH:${GOPATH}/bin:${GOROOT}/bin:${MICROPYTHON}/crosstool-NG/builds/xtensa-esp32-elf/bin"

export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:/usr/share/man:/usr/local/share/man:/Library/TeX/Distributions/.DefaultTeX/Contents/Man:/opt/X11/share/man:${HOME}/dotfiles/git-hub/man"

fpath=(~/.zsh $fpath)

# end of .zprofile
