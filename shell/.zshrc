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
# 2022-09-19 update .zshrc for m1 mac & pull zsh plugins to .zsh_plugins

#echo ".zshrc"

# Test if in Emacs or not
case ${INSIDE_EMACS/*,/} in
  (comint)
    echo 'Inside Emacs!'
    export TERM='xterm-256color'
    source ~/.zprofile
    ;;
  (tramp)
    echo "We somehow have a dumb Emacs terminal." >&2
    ;;
  ("")
    # not in Emacs, test for iterm2
    test -e ~/.iterm2_shell_integration.zsh && source ~/.iterm2_shell_integration.zsh || true
    ;;
esac



# set up pyenv
if command -v pyenv 1>/dev/null 2>&1; then
    export PYENV_ROOT="$HOME/.pyenv"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# python aliases
pipoff() {
    export PIP_REQUIRE_VIRTUALENV=false
}

pipon() {
    export PIP_REQUIRE_VIRTUALENV=true
}


# use emacsclient for programs opening an editor
VISUAL='e'
EDITOR="$VISUAL"

# needed to ensure Emacs key bindings in the CLI
bindkey -e

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
if [[ $(uname -s) == "Darwin" ]]
then
alias sl='gls'
alias ls="gls -G --color=auto"
alias la='gls -AF --color=auto' # Compact view, show hidden
alias ll='gls -al --color=auto'
alias l='gls -a --color=auto'
alias l1='gls -1 --color=auto'
else
alias sl='ls'
alias ls="ls -G --color=auto"
alias la='ls -AF --color=auto' # Compact view, show hidden
alias ll='ls -al --color=auto'
alias l='ls -a --color=auto'
alias l1='ls -1 --color=auto'
fi

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

alias h='history'
alias my='cd My\ Documents'

# power
alias shutdown='sudo shutdown -P now'
alias reboot='sudo shutdown -r now'
alias halt='sudo halt -p'

# gnu shuf for random permutations
which gshuf &>/dev/null
if [ $? -eq 0 ]; then
    alias shuf=gshuf
fi

# use most for paging if exist
if command -v most 1>/dev/null 2>&1; then
    export PAGER='most'
    alias less=most
fi

# end of .zshrc
