chpwd() {
  lsd -lah

  if [[ -f "flake.nix" && "$PWD" != "$HOME/.dotfiles"* ]]; then
    nvim .
  fi
}

bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^W' backward-kill-word
bindkey '^U' kill-whole-line
bindkey ' ' magic-space
bindkey '^I' expand-or-complete
bindkey '^R' history-incremental-search-backward
bindkey '^[[A' up-line-or-history
bindkey '^[[B' down-line-or-history
