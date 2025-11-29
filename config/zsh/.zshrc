ZSH_CUSTOM_CONFIG="/home/$USER/.dotfiles/config/zsh/"

for config_file in $ZSH_CUSTOM_CONFIG/*.zsh; do
  source "$config_file"
done
