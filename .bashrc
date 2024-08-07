# -----------------------
# bashrc
# -----------------------

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load additional configuration files
for file in ~/.dotfiles/.bash_aliases ~/.dotfiles/.bash_exports ~/.dotfiles/.bash_prompt; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
