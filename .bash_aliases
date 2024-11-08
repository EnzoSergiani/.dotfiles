# -----------------------
# Alias Definitions
# -----------------------

# ls and grep
alias ls='ls --color=auto'
alias ll='ls -la'
alias grep='grep --color=auto'

# Navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias bd='cd "$OLDPWD"'

# File operations
#alias cd='cd "$@" && ls'
cd() { builtin cd "$@" && ls; }
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -r -I --preserve-root'
alias mkdir='mkdir -p'
alias cat="bat"

# Package management
alias update='sudo pacman -Syu && yay -Syu --devel'
alias install='f_install'
alias remove='f_remove'
alias list='f_list'

# Developer shortcuts
alias python='python3'

# Typos
alias :q='exit'
alias help='man'
alias quit='exit'

# Show all logs in /var/log
alias logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs sudo tail -f"

# git
alias status="git status"
alias pull="git pull"
alias push="git push"
alias fetch="git fetch"
alias updateFromMain="git fetch origin main && git rebase origin/main"
alias add="git add"
alias commit='f() { git add "$@"; git commit -m; }; f'
alias branch='git checkout'
alias diff="git diff"
alias force="git push --force-with-lease"
# alias nuke="git clean -df && git reset --hard"
alias pop="git stash pop"
alias last="git log -1 HEAD --stat"
alias prune="git fetch --prune"
alias resolve="git add . && git commit --no-edit"
alias stash="git stash -u"
alias unstage="git restore --staged ."
alias graph="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias amend="git add . && git commit --amend --no-edit"

# LaTex
alias makeLatex="mkdir Output && pdflatex -output-directory=./Output/ main.tex"
