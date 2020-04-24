#!/usr/bin/env bash
# stow-pc.sh

# sej 2019 05 24 init

# to get stow on mingw64 system
# pacman -S mingw64/mingw-w64-x86_64-perl
# pacman -S mingw64/mingw-w64-x86_64-perl-docs
# cpan App::cpanminus
# cpanm Test::More Test::Output Log::Log4perl YAML
# cpan <enter>
# o conf yaml_module YAML <enter>
# o conf commit <enter>
# cpanm Stow --force  # it fails test on mingw


stow -t ~/ --ignore=.bash_path -v shell

# end of copybasics.sh
