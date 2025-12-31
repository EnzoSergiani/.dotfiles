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
