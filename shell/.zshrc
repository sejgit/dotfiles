#!/usr/bin/env zsh
# .zshrc for use on osx & maybe others later
# 2020-02-08 init sej
# 2020-04-04 updates between .zshrc & .zshenv


# set vars
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=5000
HISTSIZE=2000


# set options
emulate -LR zsh # reset zsh options
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

# zsh completion

# load bashcompinit for some old bash completions
autoload bashcompinit && bashcompinit

# load and init completion system
zmodload -i zsh/complist
autoload -U compinit
compinit
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/dotfiles/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix

# use the nice menu
zstyle ':completion:*:*:*:*:*' menu select

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
if [[ $(uname -s) == "Darwin" ]]
then
    alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
    alias emacsclient='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
fi

# use emacsclient for programs opening an editor
VISUAL='e'
EDITOR="$VISUAL"

alias em='emacs'
alias en='emacs -nw'
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

# alias python3='/usr/local/bin/python3'
# alias python='/usr/local/bin/python3'
# alias py='python'
# alias pip3='/usr/local/opt/python/bin/pip3'
# alias pip='/usr/local/opt/python/bin/pip3'

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

# if [ -e /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh ]
# then
#     source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
#     bindkey "^[[A" history-substring-search-up
#     bindkey "^[[B" history-substring-search-down
# else
#     if [ -e ~/.config/zsh-history-substring-search.zsh]
#     then
#         source ~/.config/zsh-history-substring-search.zsh
#         bindkey "^[[A" history-substring-search-up
#         bindkey "^[[B" history-substring-search-down
#     else
#         bindkey "^[[A" history-search-backward
#         bindkey "^[[B" history-search-forward
#     fi
# fi


# end of .zshrc
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

test -e ~/.iterm2_shell_integration.zsh && source ~/.iterm2_shell_integration.zsh || true

archey -p
# end of .zshrc
