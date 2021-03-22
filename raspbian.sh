#!/usr/bin/env bash
# raspbian.sh

# sej 2021 03 23 init

echo "###### warning this file assumes a fresh raspbian and will wreck things!!!!"
echo "# make sure before this you get the pi going through raspi-config"
echo "#      ssh-server, localization, hostname, wifi  etc"

if [[ $(uname -s) == "Linux" ]] ; then
    # get up to date
    sudo apt update
    sudo apt upgrade

    # get the basics
    # install screenfetch from apt
    sudo apt install stow git mosquitto mosquitto-cli screenfetch

    # if you want mosquitto server then:
    # sudo systemctl enable mosquitto

    # get the startup files in place
    rm ~/.bash* .profile
    stow -t ~/ -v shell

    # install antibody from brew or
    sudo curl -sfL git.io/antibody | sudo sh -s - -b /usr/local/bin

    sudo apt-key adv --keyserver hkp://keys.gnupg.net:80 --recv-keys A04A6C4681484CF1
    sudo apt-key adv --keyserver hkp://keys.gnupg.net:80 --recv-keys 648ACFD622F3D138
    sudo su -c 'echo -e "deb http://deb.debian.org/debian buster-backports main\n" >> /etc/apt/sources.list'
    sudo apt update
    sudo apt install -t buster-backports emacs-nox
    rm -rf ~/.emacs.d/
    cp -avr ~/dotfiles/mini_emacs/ ~/.emacs.d/
    emacs --version
    sudo rm -rf /etc/emacs/site-start.d
    sudo mkdir /etc/emacs/site-start.d
else
    echo "Don't run this on anything but a fresh raspbian !!!"
fi
