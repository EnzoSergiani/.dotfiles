#!/bin/bash    

cd ~/Projets/
find . -maxdepth 1 -type d  | fzf --height=100% --layout=reverse --border --margin=1 --padding=1 --preview 'tree {} -I ".*"' --bind='enter:execute(code {})+abort'
