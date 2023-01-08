#!/usr/bin/env zsh
# .zlogin for use on osx and linux
# 2022-09-21 init sej

#echo ".zlogin"

if command -v keychain 1>/dev/null 2>&1; then
    keychain id_rsa
    [[ -f ~/.keychain/sejmbp.local-sh ]] && source ~/.keychain/sejmbp.local-sh
else
    echo "keychain not installed"
fi

