#!/usr/bin/env zsh
# .zprofile for use on osx & maybe others later
# 2020-03-01 init sej
# 2020-04-04 updates between .zshrc & .zshenv & .zprofile
# 2022-09-21 updates between .zshrc & .zshenv & .zprofile
# 2023-02-15 fix for Darwin m1 & intel

#echo ".zprofile"

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

export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar";
export HOMEBREW_REPOSITORY=$HOMEBREW_PREFIX;

export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.shell/scripts:$HOME/dotfiles/git-hub/lib:$HOME/.go/bin:$HOME/perl5/bin:$HOME/node_modules:$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$HOMEBREW_PREFIX/opt/llvm/bin:$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$HOMEBREW_PREFIX/opt/go/libexec/bin:$HOMEBREW_PREFIX/opt/fzf/bin:/Library/TeX/texbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:$HOME/node_modules/.bin:$HOME/.cargo/bin"; export PATH;

export MANPATH="/usr/share/man:$HOMEBREW_PREFIX/share/man:$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:/Library/TeX/Distributions/.DefaultTeX/Contents/Man:/opt/X11/share/man:$HOME/dotfiles/git-hub/man"; export MANPATH;

export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}";

fpath=(~/.zsh $fpath)

# end of .zprofile
