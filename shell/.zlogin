#!/usr/bin/env zsh
# .zlogin for use on osx and linux
# 2022-09-21 init sej

echo ".zlogin"

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
  # OSX app aliases
  # used depending on how Emacs was installed
  #     alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
  #     alias emacsclient='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
  alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'
  alias crawl='crawl -dir ~/.config/.crawl -rc ~/.config/.crawl/init.txt'

  #  eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
  antidote_dir=$HOMEBREW_PREFIX/opt/antidote/share/antidote
fi

if [[ $(uname -s) == "FreeBSD" || $(uname -s) == "Linux" ]]; then
    echo FreeBSD/Linux
    antidote_dir=${ZDOTDIR:-~}/.antidote
fi

# Antidote
if [[ -d ${ZDOTDIR:=~}/.antidote ]]; then
    echo "Using cloned version of antidote"
    antidote_dir=${ZDOTDIR:-~}/.antidote
fi

if [[ -f ${antidote_dir}/antidote.zsh ]]; then
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
        echo "antidote needs to be installed: git clone mattmc3/antidote"
    fi
fi


if [[ -d ~/.cargo ]]; then
    . "$HOME/.cargo/env"
fi


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

# Set-up nvm for Linux
if [[ -f /usr/share/nvm/init-nvm.sh ]] && [[ $(uname -s) = "Linux" ]]; then
  source /usr/share/nvm/init-nvm.sh
fi


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

COLORTERM=truecolor


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

# set up screenfetch
if [[ $(uname -s) == "Darwin" ]]; then
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

if command -v keychain 1>/dev/null 2>&1; then
    keychain id_rsa
    [[ -f ~/.keychain/sejmbp.local-sh ]] && source ~/.keychain/sejmbp.local-sh
else
    echo "keychain not installed"
fi



