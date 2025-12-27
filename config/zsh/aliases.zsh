alias ~="cd ~"
alias /="cd /"
alias ls="lsd"
alias ll="lsd -lah"
alias ..="cd .."
alias rm="trash-put"
alias -- '-'='cd -'

alias grep="grep --color=auto"
alias open="xdg-open"
alias cls="clear"
alias now="date '+%Y-%m-%d %H:%M:%S'"

alias nix-rebuild="sudo nixos-rebuild switch"
alias nix-upgrade="sudo nixos-rebuild switch --upgrade"
alias nix-clean="sudo nix-collect-garbage -d"
alias nix-search="nix search nixpkgs"
alias nix-install="nix-env -iA nixos."
alias nix-upgrade="nix-env -u"
alias nix-remove="nix-env -e"
alias nix-list="nix-env -q"
alias nix-optimize="sudo nix-collect-garbage -d && sudo nix-store --optimise"

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
