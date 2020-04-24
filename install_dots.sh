#!/usr/bin/env bash
# install_dots.sh

# sej 2020 04 04 init

if hash stow 2>/dev/null ; then
    stow -t ~/ -v shell
else
    echo "install stow first"
    echo "linux apt install stow"
    echo "osx brew install stow"
fi

# end of install_dots.sh
