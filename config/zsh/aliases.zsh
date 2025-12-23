alias ~="cd ~"
alias /="cd /"
alias ls="lsd"
alias ll="lsd -lah"
alias ..="cd .."
alias grep="grep --color=auto"
alias open="xdg-open"

alias rebuild="sudo nixos-rebuild switch"
alias update="sudo nixos-rebuild switch --upgrade"
alias cleanup="sudo nix-collect-garbage -d"
alias nix-search="nix search nixpkgs"

nvim() {
  if [[ "$TERM" == "xterm-kitty" ]]; then
    kitty @ set-spacing padding=0
    command nvim "$@"
    local exit_code=$?
    kitty @ set-spacing padding=4
    return $exit_code
  else
    command nvim "$@"
  fi
}
