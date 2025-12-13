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
if ((( $+commands[gls] ))); then
alias sl='gls -F'
alias ls='gls -F'
alias la='gls -AF'
alias ll='gls -lAF'
alias l='gls -l'
else
alias sl='ls -F'
alias ls='ls -F'
alias la='ls -AF'
alias ll='ls -lAF'
alias l='ls -l'
fi

# gnu shuf for random permutations
which gshuf &>/dev/null
if [ $? -eq 0 ]; then
    alias shuf=gshuf
fi

# directories
alias my='cd My\ Documents'

# power
alias shutdown='sudo shutdown -P now'
alias reboot='sudo shutdown -r now'
alias halt='sudo halt -p'

# nocorrect
alias ssh='nocorrect ssh'

alias em='emacs'
alias en='emacs -nw'
alias et='emacsclient -t'
alias ed='emacs --daemon'
alias E='SUDO_EDITOR=emacsclient sudo -e'

alias e='emacsclient --alternate-editor="" --create-frame'

# use most for paging if exist
if command -v most 1>/dev/null 2>&1; then
  export PAGER='most'
  alias less=most
else
  export PAGER='less'
fi

export VISUAL='e'
export EDITOR="$VISUAL"

# extras
alias crawl='crawl -dir ~/.config/.crawl -rc ~/.config/.crawl/init.txt'
alias q='exit'
alias cls='clear'

# use bat for cat if exists
if command -v bat 1>/dev/null 2>&1; then
  alias cat='bat'
fi

# fix common typos
alias quit='exit'
alias cd..='cd ..'

# misc
alias zshrc='${EDITOR:-vim} "${ZDOTDIR:-$HOME}"/.zshrc'
alias zbench='for i in {1..10}; do /usr/bin/time zsh -lic exit; done'
alias zdot='cd ${ZDOTDIR:-~}'

# networking
alias ip='ipconfig getifaddr en0'
alias ipw='ipconfig getifaddr en0'
alias ipe='ipconfig getifaddr en1'



# Force colors in Emacs eat terminal
if [[ "$INSIDE_EMACS" == *"eat"* ]]; then
  # Force color output for ls/gls
  if command -v gls >/dev/null 2>&1; then
    alias ls='gls -F --color=always'
    alias la='gls -AF --color=always'
    alias ll='gls -lAF --color=always'
    alias l='gls -l --color=always'
  else
    alias ls='ls -FG'
    alias la='ls -AFG'
    alias ll='ls -lAFG'
    alias l='ls -lG'
  fi
  
  # Force color output for bat
  if command -v bat >/dev/null 2>&1; then
    alias bat='bat --color=always'
    alias cat='bat --color=always'
  fi
  
  # Force color for other common tools
  alias grep='grep --color=always'
  alias egrep='egrep --color=always'
  alias fgrep='fgrep --color=always'
fi
