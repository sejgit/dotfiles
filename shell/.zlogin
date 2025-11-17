#!/usr/bin/env zsh
# .zlogin for use on osx and linux
# 2022-09-21 init sej
# <2024-06-30 Sun> set for tramp
# 2024-11-17 moved fastfetch to .zshrc to work with p10k instant prompt

# for Emacs tramp
[[ $TERM == "dumb" || $TERM == "tramp" ]] && unsetopt zle && PS1='$ ' && return

# fastfetch moved to .zshrc to run before PowerLevel10k instant prompt

