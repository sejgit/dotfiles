#!/usr/bin/env zsh
# .zshenv for use on osx & maybe others later
# 2020-03-01 init sej
# 2020-04-04 updates between .zshrc & .zshenv & .zprofile
# 2020-04-22 add PERL5 to path
# 2020-12-13 fixing clang stuff
# 2022-09-19 update .zshrc for m1 mac & pull zsh plugins to .zsh_plugins
# 2023-02-15 fix for Darwin m1 & Intel


echo ".zshenv"

# set vars
export LANG="en_US.UTF-8"
export LANGUAGE="en_US:en"

if [[ $(uname -s) == "Darwin" ]] ; then
  # below are for GPG support & use
  export GPG_TTY=$(tty)
  if [[ -n "$SSH_CONNECTION" ]]
  then
    export PINENTRY_USER_DATA="USE_CURSES=1"
  fi
  export GPG_TTY=$(tty)

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

# end of .zshenv

