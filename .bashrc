# -----------------------
# bashrc
# -----------------------

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load additional configuration files
for file in ~/.dotfiles/.bash_aliases ~/.dotfiles/.bash_exports ~/.dotfiles/.bash_prompt ~/.dotfiles/.bash_fzf; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

[ -f ~/.config/forgit/forgit.plugin.sh ] && source ~/.config/forgit/forgit.plugin.sh
