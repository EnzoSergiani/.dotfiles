#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll="ls -la"
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
alias android-studio='/opt/android-studio/bin/studio.sh'
alias update='sudo pacman -Syu'
alias search='pacman -Ss'
alias install='sudo pacman -S'
alias remove='sudo pacman -R'
alias list='pacman -Qe'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"
alias mv="mv -i"
alias cp="cp -i"        
alias rm="rm -r -I --preserve-root"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
