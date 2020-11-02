#!/usr/bin/env zsh
# .zshenv for use on osx & maybe others later
# 2020-03-01 init sej
# 2020-04-04 updates between .zshrc & .zshenv & .zprofile
# 2020-04-22 add PERL5 to path

# path setup
export PATH="${HOME}/bin:${HOME}/.local/bin:${HOME}/.shell/scripts:${HOME}/dotfiles/git-hub/lib:/Users/stephenjenkins/perl5/bin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/opt/llvm/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:/Library/TeX/texbin:/opt/X11/bin:$PATH:${GOPATH}/bin:${GOROOT}/bin"

export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:/usr/share/man:/usr/local/share/man:/Library/TeX/Distributions/.DefaultTeX/Contents/Man:/opt/X11/share/man:${HOME}/dotfiles/git-hub/man"

fpath=(~/.zsh $fpath)

# set vars
export CC="/usr/local/opt/llvm/bin/clang"
export CXX="/usr/local/opt/llvm/bin/clang++"
export AR="/usr/local/opt/llvm/bin/llvm-ar"
export LD="/usr/local/opt/llvm/bin/llvm-ld"
export LDFLAGS="-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib -L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include -I/usr/local/opt/llvm/include/c++/v1/ -I/usr/local/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

# perl setup
PERL5LIB="/Users/stephenjenkins/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/stephenjenkins/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/stephenjenkins/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/stephenjenkins/perl5"; export PERL_MM_OPT;

# virtualenvwrapper
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
export WORKON_HOME=${HOME}/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# end of .zshenv
