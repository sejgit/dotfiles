#!/usr/bin/env zsh
# .zprofile for use on osx & maybe others later
# 2020-03-01 init sej
# 2020-04-04 updates between .zshrc & .zshenv & .zprofile
# 2022-09-21 updates between .zshrc & .zshenv & .zprofile

#echo ".zprofile"

# set vars
export LANG="en_US.UTF-8"
export LANGUAGE="en_US:en"

# below are for GPG support & use
export GPG_TTY=$(tty)
if [[ -n "$SSH_CONNECTION" ]]
then
    export PINENTRY_USER_DATA="USE_CURSES=1"
fi
export GPG_TTY=$(tty)


# Enable autocompletions
autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi
zmodload -i zsh/complist

# Save history so we get auto suggestions
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

# Options
setopt auto_cd # cd by typing directory name if it's not a command
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances
setopt correct_all # autocorrect commands
setopt interactive_comments # allow comments in interactive shells

# Improve autocompletion style
zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # approximate completion matches


if [[ $(uname -s) == "Darwin" ]] ; then
  # If you use bash, this technique isn't really zsh specific. Adapt as needed.
  source ~/dotfiles/shell/keychain-environment-variables.sh

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

  # OSX app aliases
  # used depending on how Emacs was installed
  #     alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
  #     alias emacsclient='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
  alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'
  alias crawl='crawl -dir ~/.config/.crawl -rc ~/.config/.crawl/init.txt'

  # OSX Brew setup for OSX & antigen path
  if [[ $(uname -p) == 'arm' ]]; then
    echo M1
    eval "$(/opt/homebrew/bin/brew shellenv)"
    antidote_dir=/opt/homebrew/opt/antidote/share/antidote
  else
    echo intel
    eval "$(/usr/local/bin/brew shellenv)"
    antidote_dir=/usr/local/opt/antidote/share/antidote
  fi
fi

if [[ $(uname -s) == "FreeBSD" ]] ; then
    echo FreeBSD
    antidote_dir=${ZDOTDIR:-~}/.antidote
fi

# Antidote
  if [[ -f ${antidote_dir}/antidote.zsh ]] ; then
    # source antidote
    plugins_txt=~/.zsh_plugins.txt
    static_file=~/.zsh_plugins.zsh
    zstyle ':antidote:bundle' use-friendly-names 'yes'

    source ${antidote_dir}/antidote.zsh
    antidote load

    # Keybindings
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
  else
    if [[ $(uname -s) == "Darwin" ]]
    then
      echo "antidote needs to be installed: brew install antidote"
    else
      echo "antidote needs to be installed with appropriate package manager."
    fi
  fi


if [[ $(uname -s) == "Darwin" ]]
then
    # Arduino setup
    export ARDUINO_DIR=/Applications/Arduino.app/Contents/Java
    export ARDMK_DIR=/usr/local/opt/arduino-mk
    #export AVR_TOOLS_DIR=/Applications/Arduino.app/Contents/Resources/Java/hardware/tools/avr
    export MONITOR_PORT=/dev/tty.usbmodem1441
    export BOARD_TAG=mega
    export BOARD_SUB=atmega2560
    export ESPLIBS=$HOME/Library/Arduino15/packages/esp8266/hardware/esp8266/2.4.1/Libraries
    export ARLIBS=$HOME/Projects/sej/Arduino/libraries

    # Go development
    export GOPATH="${HOME}/.go"
    export GOROOT="$(brew --prefix golang)/libexec"
    # export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"  # see below
    test -d "${GOPATH}" || mkdir "${GOPATH}"
    test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"

    # micropython development
    export MICROPYTHON=${HOME}/Projects/micropython/ctng-volume
    export ESPIDF=${MICROPYTHON}/esp-idf
fi

    # guile setup (GNU scripting language used by the GNU debugger GDB)
if command -v guile 1>/dev/null 2>&1; then
  export GUILE_LOAD_PATH="/usr/local/share/guile/site/3.0"
  export GUILE_LOAD_COMPILED_PATH="/usr/local/lib/guile/3.0/site-ccache"
  export GUILE_SYSTEM_EXTENSIONS_PATH="/usr/local/lib/guile/3.0/extensions"
fi

# perl setup
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;

# Set-up nvm for Linux
if [[ -f /usr/share/nvm/init-nvm.sh ]] && [[ $(uname -s) = "Linux" ]]; then
  source /usr/share/nvm/init-nvm.sh
fi


# set up screenfetch
if [[ $(uname -s) == "Darwin" ]]
then
  if command -v screenfetch 1>/dev/null 2>&1; then
    screenfetch -D 'Mac OS x'
  else
    echo "screenfetch needs to be installed for splashscreen: brew install screenfetch"
  fi
else
  if command -v screenfetch 1>/dev/null 2>&1; then
    screenfetch
  else
    echo "screenfetch needs to be installed for splashscreen.  Use appropriate package manager."
  fi
fi


# end of .zprofile
