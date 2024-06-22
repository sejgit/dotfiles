#!/usr/bin/env zsh
# .zshenv for use on osx & maybe others later
# 2020-03-01 init sej
# 2020-04-04 updates between .zshrc & .zshenv & .zprofile
# 2020-04-22 add PERL5 to path
# 2020-12-13 fixing clang stuff
# 2022-09-19 update .zshrc for m1 mac & pull zsh plugins to .zsh_plugins
# 2023-02-15 fix for Darwin m1 & Intel
# <2024-06-15 Thu> simplify
# echo ".zshenv"


###############
# Set ZDOTDIR #
###############
# some improvements from [[https://github.com/getantidote/zdotdir/blob/main/.zshenv][zdotdir]]
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export ZDOTDIR=${ZDOTDIR:-$HOME/dotfiles/shell}

##################
# OSX Brew setup #
##################
if [[ $(uname -s) == "Darwin" ]]; then
  if [[ $(uname -p) == 'arm' ]]; then
    #echo M1
    export HOMEBREW_PREFIX="/opt/homebrew";
  else
    #echo Intel
    export HOMEBREW_PREFIX="/usr/local";
  fi
fi

#####################
# Set C environment #
#####################
if [[ $(uname -s) == "Darwin" ]]; then
  if [ -x /usr/libexec/path_helper ]; then
	eval `/usr/libexec/path_helper -s`
  fi
  if type brew &>/dev/null; then
    export  LDFLAGS="-L$HOMEBREW_PREFIX/opt/llvm/lib/c++ -Wl,-rpath,$HOMEBREW_PREFIX/opt/llvm/lib/c++"
    export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/llvm/include"
  else
    echo "HomeBrew is required for this dotfile on macOS!!!"
  fi
fi

#############
# .zprofile #
#############
# .zprofile to set environment vars for non-login, non-interactive shells.
# if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
if [[ ( ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# end of .zshenv
