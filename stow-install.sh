#!/usr/bin/env bash
# stow-install.sh

# sej 2019 05 24 init
# update 2020 12 27 update for linux

# to get stow on mingw64 system
# pacman -S mingw64/mingw-w64-x86_64-perl
# pacman -S mingw64/mingw-w64-x86_64-perl-docs
# cpan App::cpanminus
# cpanm Test::More Test::Output Log::Log4perl YAML
# cpan <enter>
# o conf yaml_module YAML <enter>
# o conf commit <enter>
# cpanm Stow --force  # it fails test on mingw


# install stow from apt or brew
stow -t ~/ -v shell

# install screenfetch from apt or brew
# install antibody from brew or
# sudo curl -sfL git.io/antibody | sudo sh -s - -b /usr/local/bin


# end of stow-install.sh
