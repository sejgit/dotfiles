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
# <2024-06-30 Sun> set for tramp

# printf ".zshrc"

#########
# Emacs #
#########
# needed to ensure Emacs key bindings in the CLI
bindkey -e

# Test if in Emacs or not
case ${INSIDE_EMACS/*,/} in
  (eat)
    printf 'Inside Emacs/Eat\n'
    source ${ZDOTDIR:-~}/.zlogin
    [ -n "$EAT_SHELL_INTEGRATION_DIR" ] && source "$EAT_SHELL_INTEGRATION_DIR/zsh"
    ;;
  (comint)
    printf 'Inside Emacs!\n'
    export TERM='xterm-256color'
    source ${ZDOTDIR:-~}/.zlogin
    ;;
  (tramp)
    printf "We have a dumb Emacs terminal.\n" >&2
      unsetopt zle
      export PS1="$ "
      return
    ;;
  (dumb)
    printf "We have a dumb Emacs terminal.\n" >&2
      unsetopt zle
      export PS1="$ "
      return
    ;;
  ("")
    if [[ $TERM == "dumb" || $TERM == "tramp" ]]; then
      unsetopt zle
      export PS1="$ "
      return
    else
      # not in Emacs, test for iterm2
      test -e ~/.iterm2_shell_integration.zsh && source ~/.iterm2_shell_integration.zsh || true
    fi
    ;;
esac

#########
# vars  #
#########
export LANG="en_US.UTF-8"
export LANGUAGE="en_US:en"

#############################################
# Save history so we get auto suggestions #
#############################################
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

###########
# Options #
###########
setopt append_create
setopt auto_cd # cd by typing directory name if it's not a command
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances
# setopt correct_all # autocorrect commands
setopt interactive_comments # allow comments in interactive shells
setopt +o extended_glob
# setopt +o nullglob
COLORTERM=truecolor


###############
# Completions #
###############
# Enable autocompletions
if type brew &>/dev/null; then
  fpath+=$HOMEBREW_PREFIX/share/zsh/site-functions
fi
# ruff completion needs ruff generate-shell-completion zsh > ~/.zfunc/_ruff
fpath+=~/.zfunc
# Autoload functions you might want to use with antidote.
ZFUNCDIR=${ZFUNCDIR:-$ZDOTDIR/functions}
fpath+=$ZFUNCDIR
autoload -Uz $fpath[1]/*(.:t)
autoload -Uz compinit
compinit -C
zmodload -i zsh/complist

# Improve autocompletion style
zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # approx completion

############
# Antidote #
############
if [[ -d ~/.antidote ]]; then
    printf "Using cloned version of antidote\n"
    # git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
    antidote_dir=~/.antidote
else
  if [[ $(uname -s) == "Darwin" ]]; then
     #  eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
     antidote_dir=$HOMEBREW_PREFIX/opt/antidote/share/antidote
  fi
fi
if [[ -f ${antidote_dir}/antidote.zsh ]]; then
    plugins_txt=${ZDOTDIR:-~}/.zsh_plugins.txt
    static_file=${ZDOTDIR:-~}/.zsh_plugins.zsh
    zstyle ':antidote:bundle' use-friendly-names 'yes'
    zstyle ':antidote:bundle' file ${ZDOTDIR:-~}/.zsh_plugins.txt
    source ${antidote_dir:-~}/antidote.zsh
    antidote load

    if command -v register-python-argcomplete 1>/dev/null 2>&1; then
      eval "$(register-python-argcomplete pipx)"
    fi
else
    if [[ $(uname -s) == "Darwin" ]]
    then
        printf "antidote needs to be installed: brew install antidote\n"
    else
        printf "antidote needs to be installed: git clone mattmc3/antidote\n"
    fi
fi

###############
# Keybindings #
###############
bindkey '\e[A' history-beginning-search-backward
bindkey '\eOA' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward
bindkey '\eOB' history-beginning-search-forward
zle -A {.,}history-incremental-search-forward
zle -A {.,}history-incremental-search-backward
bindkey '^[[5D' emacs-backward-word
bindkey '^[[5C' emacs-forward-word
bindkey '^J' self-insert

###########
# aliases #
###########
source ${ZDOTDIR:-~}/.aliases.zsh

##################
# macos specific #
##################
if [[ $(uname -s) == "Darwin" ]] ; then
  # brew-wrap wraps the original brew command for an automatic update of Brewfile
  #   when you execute such a brew install or brew uninstall.
  if [ -f $(brew --prefix)/etc/brew-wrap ];then
	source $(brew --prefix)/etc/brew-wrap
  fi
  # below are for GPG support & use
  export GPG_TTY=$(tty)
  if [[ -n "$SSH_CONNECTION" ]]
  then
    export PINENTRY_USER_DATA="USE_CURSES=1"
  fi
  export GPG_TTY=$(tty)

  source ${ZDOTDIR:-~}/keychain-environment-variables.sh

  if command -v aws 1>/dev/null 2>&1; then
    # OSX keychain environment variables
    # AWS configuration example, after doing:
    # $  set-keychain-environment-variable AWS_ACCESS_KEY_ID
    #       provide: "AKIAYOURACCESSKEY"
    export AWS_ACCESS_KEY_ID=$(keychain-environment-variable AWS_ACCESS_KEY_ID);
    # $  set-keychain-environment-variable AWS_SECRET_ACCESS_KEY
    #       provide: "j1/yoursupersecret/password"
    export AWS_SECRET_ACCESS_KEY=$(keychain-environment-variable AWS_SECRET_ACCESS_KEY);
  fi

  # micropython development
  export MICROPYTHON=${HOME}/Projects/micropython/ctng-volume
  export ESPIDF=${MICROPYTHON}/esp-idf

  # guile setup (GNU scripting language used by the GNU debugger GDB)
  if command -v guile 1>/dev/null 2>&1; then
    export GUILE_LOAD_PATH="$HOMEBREW_PREFIX/share/guile/site/3.0"
    export GUILE_LOAD_COMPILED_PATH="$HOMEBREW_PREFIX/lib/guile/3.0/site-ccache"
    export GUILE_SYSTEM_EXTENSIONS_PATH="$HOMEBREW_PREFIX/lib/guile/3.0/extensions"
  fi

  # perl setup
  PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
  PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
  PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
  PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;
fi

####################
# freeBSD specific #
####################
if [[ $(uname -s) == "FreeBSD" || $(uname -s) == "Linux" ]]; then
  printf FreeBSD
fi

##################
# Linux specific #
##################
if [[ $(uname -s) == "Linux" ]]; then
    printf Linux
    if [[ -f /usr/share/nvm/init-nvm.sh ]]; then
      source /usr/share/nvm/init-nvm.sh
    else
      printf "nvm not installed\n"
    fi
fi

#########
# cargo #
#########
if test -e $HOME/.cargo/bin/cargo; then
  . "$HOME/.cargo/env"
else
  printf "cargo not installed, see readme\n"
fi

########
# pipx #
########
if command -v pipx 1>/dev/null 2>&1; then
  # maybe add more checks later
else
  printf "pipx not installed"
  printf "  macos: brew install pipx"
  printf "  linux: apt install pipx"
  printf "  freebsd: python3 -m pip install --user pipx"
  printf
fi

#########
# pyenv #
#########
if command -v pyenv 1>/dev/null 2>&1; then
    export PYENV_ROOT="$HOME/.pyenv"
    eval "$(pyenv init -)"
    if eval "$(pyenv virtualenv-init -)" ; then
       # printf yay
    else
      printf "pyenv-virtualenv not installed"
      printf "  macos: brew install pyenv-virtualenv"
      printf "  linux: git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv"
      printf "  freebsd: git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv"
      printf
    fi
else
  printf "pyenv not installed"
  printf "  macos: brew install pyenv"
  printf "  linux: apt install pyenv"
  printf "  freebsd: pkg install pyenv"
  printf
fi

##########
# pipenv #
##########
if command -v pipenv 1>/dev/null 2>&1; then
    eval "$(_PIPENV_COMPLETE=zsh_source pipenv)"
else
  printf "pipenv not installed"
  printf "macos  brew install pipenv"
  printf "freebsd  pip install pipenv --user"
  printf
fi

##########
# direnv #
##########
if command -v direnv 1>/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
else
  printf "direnv not installed"
  printf "  macos: brew install direnv"
  printf "  linux: apt install direnv"
  printf "  freebsd: pkg install direnv"
  printf
fi

############
# Keychain #
############
if command -v keychain 1>/dev/null 2>&1; then
  if [[ $(uname -s) == "Darwin" ]]
  then
    export GPG_AGENT_INFO="~/.gnupg/S.gpg-agent:$(pgrep gpg-agent):1"
    eval `keychain --eval --ssh-spawn-gpg --ssh-allow-forwarded`
  else
    export GPG_AGENT_INFO="~/.gnupg/S.gpg-agent:$(pgrep gpg-agent):1"
    eval `keychain --eval --agents gpg,ssh --inherit any id_rsa`
  fi
else
    printf "keychain not installed\n"
fi

########################
# PowerLevel10k prompt #
########################
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
if [[ ! -f ${ZDOTDIR:-~}/.p10k.zsh ]]
then
  "printf p10k not installed or set-up\n"
else
  source ${ZDOTDIR:-~}/.p10k.zsh
fi

# end of .zshrc
