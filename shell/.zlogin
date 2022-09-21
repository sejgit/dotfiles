#!/usr/bin/env zsh
# .zlogin for use on osx and linux
# 2022-09-21 init sej

#echo ".zlogin"

keychain id_rsa
[[ -f ~/.keychain/sejmbp.local-sh ]] && source ~/.keychain/sejmbp.local-sh
