#!/bin/env zsh
# .zshrc for use on osx & maybe others later
# 2020-02-08 init sej


emulate -LR zsh # reset zsh options

# set vars
export LANG="en_US.UTF-8"
export LANGUAGE="en_US:en"
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=5000
HISTSIZE=2000


# set options
setopt AUTO_CD
setopt NO_CASE_GLOB
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt CORRECT
setopt CORRECT_ALL

# path setup
export PATH=/usr/local/opt/coreutils/libexec/gnubin:/usr/bin:/bin:/usr/sbin:/sbin:~/bin:~/.local/bin:~/.shell/scripts:~/dotfiles/git-hub/lib:/usr/local/sbin:/usr/local/bin:$PATH
export MANPATH="=~/dotfiles/git-hub/man:/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

fpath=(~/.zsh $fpath)

# zsh completion

# case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix

# load bashcompinit for some old bash completions
autoload bashcompinit && bashcompinit

# load and init completion system
autoload -Uz compinit && compinit

# prompt
source ~/.zsh/git-prompt.sh
PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{7}%3~%f%b %# '
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
GIT_PS1_SHOWDIRTYSTATE="true"
GIT_PS1_SHOWSTASHSTATE="true"
GIT_PS1_SHOWUNTRACKEDFILES="true"
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS="true"
GIT_PS1_DESCRIBE_STYLE="default"
RPROMPT='$(__git_ps1 "(%s)")'
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git


# below are for GPG support & use
export GPG_TTY=$(tty)
if [ -n "$SSH_CONNECTION" ]; then
    export PINENTRY_USER_DATA="USE_CURSES=1"
fi
export GPG_TTY=$(tty)


# aliases
alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'
alias crawl='crawl -dir ~/.config/.crawl -rc ~/.config/.crawl/init.txt'

pipoff() {
    export PIP_REQUIRE_VIRTUALENV=false
}

pipon() {
    export PIP_REQUIRE_VIRTUALENV=true
}


# Emacs aliases

#set-up for darwin (not always used)
#if [ $(uname -s) == "Darwin" ]; then
#    alias emacs=/Applications/Emacs.app/Contents/MacOS/Emacs
#fi

# use emacsclient for programs opening an editor
VISUAL='e'
EDITOR="$VISUAL"

alias em='emacs'
alias en='emacs -nw'
# alias e='emacsclient -n'
alias et='emacsclient -t'
alias ed='emacs --daemon'
alias E='SUDO_EDITOR=emacsclient sudo -e'

alias e='emacsclient --alternate-editor="" --create-frame'

# git Aliases
alias gcl='git clone'
alias ga='git add'
alias gall='git add -A'
alias gf='git fetch --all --prune'
alias gft='git fetch --all --prune --tags'
alias gfv='git fetch --all --prune --verbose'
alias gftv='git fetch --all --prune --tags --verbose'
alias gus='git reset HEAD'
alias gm="git merge"
alias g='git'
alias get='git'
alias gst='git status'
alias gs='git status'
alias gss='git status -s'
alias gsu='git submodule update --init --recursive'
alias gl='git pull'
alias gpr='git pull --rebase'
alias gpp='git pull && git push'
alias gup='git fetch && git rebase'
alias gp='git push'
alias gpo='git push origin'
alias gpu='git push --set-upstream'
alias gpom='git push origin master'
alias gdv='git diff -w "$@" | vim -R -'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcm='git commit -v -m'
alias gci='git commit --interactive'
alias gb='git branch'
alias gba='git branch -a'
alias gbt='git branch --track'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gct='git checkout --track'
alias gexport='git archive --format zip --output'
alias gdel='git branch -D'
alias gmu='git fetch origin -v; git fetch upstream -v; git merge upstream/master'
alias gll='git log --graph --pretty=oneline --abbrev-commit'
alias gg="git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative"
alias ggs="gg --stat"
alias gsl="git shortlog -sn"
alias gw="git whatchanged"
alias gt="git tag"
alias gta="git tag -a"
alias gtd="git tag -d"
alias gtl="git tag -l"
# From http://blogs.atlassian.com/2014/10/advanced-git-aliases/
# Show commits since last pull
alias gnew="git log HEAD@{1}..HEAD@{0}"
# Add uncommitted and unstaged changes to the last commit
alias gcaa="git commit -a --amend -C HEAD"
alias gtls='git tag -l | sort -V'
alias gd="git diff | $EDITOR"

# List directory contents
alias sl=ls
alias ls="ls -G --color=auto"
alias la='ls -AF' # Compact view, show hidden
alias ll='ls -al'
alias l='ls -a'
alias l1='ls -1'

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
#alias -- -="cd -"

alias _="sudo -EH "
alias sudo='sudo -EH ' # enable alias expansion for sudo
alias root='sudo -EH su'
alias g='git'
alias make='make --debug=b'
alias ping='_ ping -c 8'
alias r='run'
alias q='exit'
alias c='clear'
alias k='clear'
alias cls='clear'

alias edit="$EDITOR"
alias pager="$PAGER"
alias py='python'

alias h='history'
alias my='cd My\ Documents'

# power
alias shutdown='sudo shutdown -P now'
alias reboot='sudo shutdown -r now'
alias halt='sudo halt -p'

which gshuf &>/dev/null
if [ $? -eq 0 ]; then
    alias shuf=gshuf
fi

bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# Arduino setup
export ARDUINO_DIR=/Applications/Arduino.app/Contents/Java
export ARDMK_DIR=/usr/local/opt/arduino-mk
#export AVR_TOOLS_DIR=/Applications/Arduino.app/Contents/Resources/Java/hardware/tools/avr
export MONITOR_PORT=/dev/tty.usbmodem1441
export BOARD_TAG=mega
export BOARD_SUB=atmega2560
export ESPLIBS=$HOME/Library/Arduino15/packages/esp8266/hardware/esp8266/2.4.1/Libraries
export ARLIBS=$HOME/Projects/sej/Arduino/libraries


# proxy settings
if [ -f ~/.ssh/myauth ] && [ -f ~/.ssh/myproxy ] && [ -f ~/.ssh/myport ]; then
    MYAUTH=$(<~/.ssh/myauth)
    MYPROXY=$(<~/.ssh/myproxy)
    MYPORT=$(<~/.ssh/myport)
    export BASH_IT_HTTP_PROXY=$(printf "http://%s@%s:%s" "$MYAUTH" "$MYPROXY" "$MYPORT")
    export BASH_IT_HTTPS_PROXY=$(printf "http://%s@%s:%s" "$MYAUTH" "$MYPROXY" "$MYPORT")
    export BASH_IT_NO_PROXY=$(<~/.ssh/noproxy)
    export GIT_MYAUTH=~/.ssh/myauth.git
fi

# Go development
export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"


# end of .zshrc
