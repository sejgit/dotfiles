#!/usr/bin/env zsh
# .zshenv for use on osx & maybe others later
# 2020-03-01 init sej
# 2020-04-04 updates between .zshrc & .zshenv & .zprofile
# 2020-04-22 add PERL5 to path
# 2020-12-13 fixing clang stuff
# 2022-09-19 update .zshrc for m1 mac & pull zsh plugins to .zsh_plugins
# 2023-02-15 fix for Darwin m1 & Intel
# <2024-04-11 Thu> simplify

#echo ".zshenv"
if [[ $(uname -s) == "Darwin" ]]; then
  # OSX Brew setup
  if [[ $(uname -p) == 'arm' ]]; then
    #echo M1
    export HOMEBREW_PREFIX="/opt/homebrew";
  else
    #echo Intel
    export HOMEBREW_PREFIX="/usr/local";
  fi
  export  LDFLAGS="-L$HOMEBREW_PREFIX/opt/llvm/lib/c++ -Wl,-rpath,$HOMEBREW_PREFIX/opt/llvm/lib/c++"
  export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/llvm/include"
else
  export HOMEBREW_PREFIX="/usr/local/" # make the path work for non-Darwin
fi

export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.shell/scripts:$HOME/dotfiles/git-hub/lib:$HOME/.go/bin:$HOME/perl5/bin:$HOME/node_modules:$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$HOMEBREW_PREFIX/opt/llvm/bin:$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$HOMEBREW_PREFIX/opt/go/libexec/bin:$HOMEBREW_PREFIX/opt/fzf/bin:/Library/TeX/texbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:$HOME/node_modules/.bin:$HOME/.cargo/bin"; export PATH;

export MANPATH="/usr/share/man:$HOMEBREW_PREFIX/share/man:$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:/Library/TeX/Distributions/.DefaultTeX/Contents/Man:/opt/X11/share/man:$HOME/dotfiles/git-hub/man"; export MANPATH;

export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}";

# end of .zshenv


# Begin added by argcomplete
fpath=( /Users/stephenjenkins/.local/pipx/venvs/argcomplete/lib/python3.12/site-packages/argcomplete/bash_completion.d "${fpath[@]}" )
# End added by argcomplete
