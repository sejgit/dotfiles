#!/usr/bin/env zsh
# .zshenv for use on osx & maybe others later
# 2020-03-01 init sej
# 2020-04-04 updates between .zshrc & .zshenv & .zprofile
# 2020-04-22 add PERL5 to path
# 2020-12-13 fixing clang stuff
# 2022-09-19 update .zshrc for m1 mac & pull zsh plugins to .zsh_plugins
# 2023-02-15 fix for Darwin m1 & Intel
# <2024-04-11 Thu> simplify

echo ".zshenv"
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
  export HOMEBREW_PREFIX="/usr/local/" # make the path work for non-Darwin
fi

# end of .zshenv

