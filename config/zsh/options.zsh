chpwd() {
  lsd -lah
  if [[ -f "flake.nix" && "$PWD" != "$HOME/.dotfiles"* && -z "$IN_NVIM" ]]; then
    IN_NVIM=1 nvim .
  fi
}

flake-init() {
  if [[ -z "$1" ]]; then
    echo "Usage: flake-init <c|cpp|python|rust|letter|report|resume>"
    return 1
  fi
  nix flake init -t "path:$HOME/.dotfiles/nixos#$1" && echo 'use flake' >.envrc && direnv allow
}
_flake_init_templates() {
  local -a templates
  templates=(c cpp python rust letter report resume)
  _describe 'template' templates
}
compdef _flake_init_templates flake-init

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
