#!/usr/bin/env zsh
# .zprofile for use on osx & maybe others later
# 2020-03-01 init sej
# 2020-04-04 updates between .zshrc & .zshenv & .zprofile
# 2022-09-21 updates between .zshrc & .zshenv & .zprofile
# 2023-02-15 fix for Darwin m1 & intel
# 2024-06-15 better brew prefix fix
# echo ".zprofile"

###########
# browser #
###########
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER="${BROWSER:-open}"
fi

##################
# homebrew paths #
##################
export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar";
export HOMEBREW_REPOSITORY=$HOMEBREW_PREFIX;
export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}";

####################
# setting defaults #
####################
export EDITOR="${EDITOR:-e}"
export VISUAL="${VISUAL:-e}"
export PAGER="${PAGER:-less}"

################
# paths for zsh #
################
# Ensure path arrays do not contain duplicates.
typeset -gU path fpath PATH

path=(
  $HOME/{,s}bin(N)
  /opt/local/{,s}bin(N)
  $HOMEBREW_PREFIX/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)

export MANPATH="/usr/share/man:$HOMEBREW_PREFIX/share/man:$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:/Library/TeX/Distributions/.DefaultTeX/Contents/Man:/opt/X11/share/man:$HOME/dotfiles/git-hub/man"; export MANPATH;

export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}";

fpath=(~/.zsh $fpath)

# end of .zprofile
