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

#########
# Emacs #
#########
# needed to ensure Emacs key bindings in the CLI
bindkey -e

# Test if in Emacs or not
case ${INSIDE_EMACS/*,/} in
  (eat)
    source ${ZDOTDIR:-~}/.zlogin
    [ -n "$EAT_SHELL_INTEGRATION_DIR" ] && source "$EAT_SHELL_INTEGRATION_DIR/zsh"
    ;;
  (comint)
    export TERM='xterm-256color'
    source ${ZDOTDIR:-~}/.zlogin
    ;;
  (tramp)
      unsetopt zle
      export PS1="$ "
      return
    ;;
  (dumb)
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
      [[ -e ~/.iterm2_shell_integration.zsh ]] && source ~/.iterm2_shell_integration.zsh
    fi
    ;;
esac

##########
# direnv #
##########
# Silence direnv output for p10k instant prompt compatibility
export DIRENV_LOG_FORMAT=""

#############
# Fastfetch #
#############
# Display system info on login shells (must be before p10k instant prompt)
if [[ -o login ]]; then
  if [[ $(uname -s) == "Darwin" ]]; then
    if command -v fastfetch 1>/dev/null 2>&1; then
      fastfetch
    fi
  else
    if command -v fastfetch 1>/dev/null 2>&1; then
      fastfetch
    fi
  fi
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
    antidote_dir=~/.antidote
else
  if [[ $(uname -s) == "Darwin" ]]; then
     antidote_dir=$HOMEBREW_PREFIX/opt/antidote/share/antidote
  fi
fi
if [[ -f "${antidote_dir}/antidote.zsh" ]]; then
    plugins_txt=${ZDOTDIR:-~}/.zsh_plugins.txt
    static_file=${ZDOTDIR:-~}/.zsh_plugins.zsh
    zstyle ':antidote:bundle' use-friendly-names 'yes'
    zstyle ':antidote:bundle' file ${ZDOTDIR:-~}/.zsh_plugins.txt
    source "${antidote_dir}/antidote.zsh"
    antidote load

    if command -v register-python-argcomplete 1>/dev/null 2>&1; then
      eval "$(register-python-argcomplete pipx)"
    fi
else
    if [[ $(uname -s) == "Darwin" ]]; then
        printf "antidote needs to be installed: brew install antidote\n" >&2
    else
        printf "antidote needs to be installed: git clone mattmc3/antidote\n" >&2
    fi
fi

###############
# Keybindings #
###############
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
  if [[ -n "$SSH_CONNECTION" ]]
  then
    export PINENTRY_USER_DATA="USE_CURSES=1"
  fi
  source ${ZDOTDIR:-~}/keychain-environment-variables.sh

  if command -v aws 1>/dev/null 2>&1; then
    # OSX keychain environment variables
    # AWS configuration example, after doing:
    # $  set-keychain-environment-variable AWS_ACCESS_KEY_ID
    #       provide: "AKIAYOURACCESSKEY"
    AWS_ACCESS_KEY_ID=$(keychain-environment-variable AWS_ACCESS_KEY_ID 2>/dev/null)
    [[ -n "$AWS_ACCESS_KEY_ID" ]] && export AWS_ACCESS_KEY_ID
    # $  set-keychain-environment-variable AWS_SECRET_ACCESS_KEY
    #       provide: "j1/yoursupersecret/password"
    AWS_SECRET_ACCESS_KEY=$(keychain-environment-variable AWS_SECRET_ACCESS_KEY 2>/dev/null)
    [[ -n "$AWS_SECRET_ACCESS_KEY" ]] && export AWS_SECRET_ACCESS_KEY
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
    if [[ -f /usr/share/nvm/init-nvm.sh ]]; then
      source /usr/share/nvm/init-nvm.sh
    else
      printf "nvm not installed\n" >&2
    fi
fi

#########
# cargo #
#########
if [[ -f "$HOME/.cargo/env" ]]; then
  . "$HOME/.cargo/env"
else
  printf "cargo not installed, see readme\n" >&2
fi

########
# pipx #
########
if ! command -v pipx 1>/dev/null 2>&1; then
  printf "pipx not installed\n" >&2
  printf "  macos: brew install pipx\n" >&2
  printf "  linux: apt install pipx\n" >&2
  printf "  freebsd: python3 -m pip install --user pipx\n" >&2
fi

#########
# pyenv #
#########
if command -v pyenv 1>/dev/null 2>&1; then
    export PYENV_ROOT="$HOME/.pyenv"
    eval "$(pyenv init -)"
    if ! eval "$(pyenv virtualenv-init -)" 2>/dev/null; then
      printf "pyenv-virtualenv not installed\n" >&2
      printf "  macos: brew install pyenv-virtualenv\n" >&2
      printf "  linux: git clone https://github.com/pyenv/pyenv-virtualenv.git \$(pyenv root)/plugins/pyenv-virtualenv\n" >&2
      printf "  freebsd: git clone https://github.com/pyenv/pyenv-virtualenv.git \$(pyenv root)/plugins/pyenv-virtualenv\n" >&2
    fi
else
  printf "pyenv not installed\n" >&2
  printf "  macos: brew install pyenv\n" >&2
  printf "  linux: apt install pyenv\n" >&2
  printf "  freebsd: pkg install pyenv\n" >&2
fi

##########
# pipenv #
##########
if command -v pipenv 1>/dev/null 2>&1; then
    eval "$(_PIPENV_COMPLETE=zsh_source pipenv)"
else
  printf "pipenv not installed\n" >&2
  printf "  macos: brew install pipenv\n" >&2
  printf "  freebsd: pip install pipenv --user\n" >&2
fi

##########
# direnv #
##########
# Hook for direnv (DIRENV_LOG_FORMAT set earlier before instant prompt)
if command -v direnv 1>/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
else
  printf "direnv not installed\n" >&2
  printf "  macos: brew install direnv\n" >&2
  printf "  linux: apt install direnv\n" >&2
  printf "  freebsd: pkg install direnv\n" >&2
fi

############
# Keychain #
############
if command -v keychain 1>/dev/null 2>&1; then
  if [[ $(uname -s) == "Darwin" ]]; then
    eval $(keychain --eval --quiet id_rsa 2>/dev/null)
    export GPG_TTY=$(tty)
    gpgconf --launch gpg-agent 2>/dev/null
  else
    export GPG_AGENT_INFO="~/.gnupg/S.gpg-agent:$(pgrep gpg-agent):1"
    eval $(keychain --eval --agents gpg,ssh --inherit any id_rsa 2>/dev/null)
  fi
else
    printf "keychain not installed\n" >&2
fi

########################
# PowerLevel10k prompt #
########################
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
if [[ -f "${ZDOTDIR:-~}/.p10k.zsh" ]]; then
  source "${ZDOTDIR:-~}/.p10k.zsh"
else
  printf "p10k not installed or set-up\n" >&2
fi

# end of .zshrc
