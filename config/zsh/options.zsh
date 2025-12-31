chpwd() {
  ls -lah

  # Virtual environment auto-activation
  local venv_names=("venv" "env" ".venv" ".env")
  local venv_found=false
  for venv_name in $venv_names; do
    if [[ -f "$venv_name/bin/activate" ]]; then
      if [[ -n "$VIRTUAL_ENV" ]]; then
        deactivate 2>/dev/null
      fi
      source "$venv_name/bin/activate"
      venv_found=true
      break
    fi
  done
  if [[ "$venv_found" = false && -n "$VIRTUAL_ENV" ]]; then
    deactivate 2>/dev/null
  fi
}

bindkey ' ' magic-space
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^ ' expand-or-complete
bindkey '^W' backward-kill-word
bindkey '^U' kill-whole-line
bindkey '^R' history-incremental-search-backward
bindkey '^[[A' up-line-or-history
bindkey '^[[B' down-line-or-history
bindkey '^I' expand-or-complete
