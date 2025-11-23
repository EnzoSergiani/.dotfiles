export ZSH="$HOME/.oh-my-zsh"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-completions
)

source $ZSH/oh-my-zsh.sh

ZSH_CUSTOM_CONFIG="$HOME/.config/zsh"

for config_file in $ZSH_CUSTOM_CONFIG/*.zsh; do
  source "$config_file"
done

