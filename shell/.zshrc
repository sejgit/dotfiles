# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#!/usr/bin/env zsh
# .zshrc for use on osx & maybe others later
# 2020-02-08 init sej
# 2020-04-04 updates between .zshrc & .zshenv
# 2020-10-29 fix for non-darwin and clean-up
# 2021-01-04 add eln stuff
# 2021-11-27 mods for Emacs shell mode
# 2021-12-16 add OSX keychain environment variables
# 2022-01-24 clean up and adds to work on other systems
# 2022-09-17 switch to antidote from antibody(depreciated)
# 2023-02-15 fix for Darwin m1 & Intel

echo ".zshrc"

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

export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar";
export HOMEBREW_REPOSITORY=$HOMEBREW_PREFIX;

export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.shell/scripts:$HOME/dotfiles/git-hub/lib:$HOME/.go/bin:$HOME/perl5/bin:$HOME/node_modules:$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$HOMEBREW_PREFIX/opt/llvm/bin:$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$HOMEBREW_PREFIX/opt/go/libexec/bin:$HOMEBREW_PREFIX/opt/fzf/bin:/Library/TeX/texbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:$HOME/node_modules/.bin"; export PATH;

export MANPATH="/usr/share/man:$HOMEBREW_PREFIX/share/man:$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:/Library/TeX/Distributions/.DefaultTeX/Contents/Man:/opt/X11/share/man:$HOME/dotfiles/git-hub/man"; export MANPATH;

export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}";

fpath=(~/.zsh $fpath)

# Test if in Emacs or not
case ${INSIDE_EMACS/*,/} in
  (eat)
    echo 'Inside Emacs/Eat'
    source ~/.zlogin
    ;;
  (comint)
    echo 'Inside Emacs!'
    export TERM='xterm-256color'
    source ~/.zlogin
    ;;
  (tramp)
    echo "We somehow have a dumb Emacs terminal." >&2
    ;;
  ("")
    # not in Emacs, test for iterm2
    test -e ~/.iterm2_shell_integration.zsh && source ~/.iterm2_shell_integration.zsh || true
    ;;
esac

[ -n "$EAT_SHELL_INTEGRATION_DIR" ] && \
  source "$EAT_SHELL_INTEGRATION_DIR/zsh"

# end of .zshrc

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
