#!/bin/bash
# todo.txt-cli.aliases.sh
# sej 2016 03 15

export TODO='todo.sh'
alias t=$TODO
alias tls="$TODO ls"
alias ta="$TODO a"
alias trm="$TODO rm"
alias tdo="$TODO do"
alias tpri="$TODO pri"
complete -F _todo t
complete -F _todo todo.sh
