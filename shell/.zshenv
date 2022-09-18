#!/usr/bin/env zsh
# .zshenv for use on osx & maybe others later
# 2020-03-01 init sej
# 2020-04-04 updates between .zshrc & .zshenv & .zprofile
# 2020-04-22 add PERL5 to path
# 2020-12-13 fixing clang stuff

# path setup
if [[ $(uname -s) == "Darwin" ]]
then
PATH="$HOME/.pyenv/shims:$HOME/bin:$HOME/.local/bin:$HOME/.shell/scripts:$HOME/dotfiles/git-hub/lib:/usr/local/opt/llvm/bin:$HOME/perl5/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/TeX/texbin:/opt/X11/bin:/Library/Apple/usr/bin:/usr/local/sbin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/Cellar/pyenv-virtualenv/1.1.5/shims:$HOME/.go/bin:/usr/local/opt/go/libexec/bin:/usr/local/opt/fzf/bin"; export PATH;

MANPATH="/usr/share/man:/usr/local/share/man:/Library/TeX/Distributions/.DefaultTeX/Contents/Man:/opt/X11/share/man:/usr/local/opt/coreutils/libexec/gnuman:$HOME/dotfiles/git-hub/man"; export MANPATH;
else
    # path for later
fi

fpath=(~/.zsh $fpath)

if [[ $(uname -s) == "Darwin" ]]
then
# set vars for llvm compilation, lets see if we can live without for now
# if [ "$(brew info llvm 2>&1 | grep -c 'Built from source on')" = 1 ]; then
#     #we are using a homebrew clang, need new flags
#     export CC="/usr/local/opt/llvm/bin/clang"
#     export CXX="/usr/local/opt/llvm/bin/clang++"
#     export AR="/usr/local/opt/llvm/bin/llvm-ar"
#     export LD="/usr/local/opt/llvm/bin/llvm-ld"
#     export LDFLAGS="-L/usr/local/opt/zlib/lib -L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib -L$(brew --prefix openssl)/lib -L$(xcrun --show-sdk-path)/usr/lib"
#     export CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/llvm/include -I/usr/local/opt/llvm/include/c++/v1/ -I$(brew --prefix openssl)/include -I$(xcrun --show-sdk-path)/usr/include"
    export LDFLAGS="-L/usr/local/opt/llvm/lib"
    export CPPFLAGS="-I/usr/local/opt/llvm/include"
#     export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"
# else
#     export LDFLAGS="-L/usr/local/opt/zlib/lib -L$(brew --prefix openssl)/lib -L$(xcrun --show-sdk-path)/usr/lib"
#     export CPPFLAGS="-I/usr/local/opt/zlib/include -I$(brew --prefix openssl)/include -I$(xcrun --show-sdk-path)/usr/include"
#     export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"
# fi

# perl setup
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;

fi

# end of .zshenv
