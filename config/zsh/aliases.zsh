alias ~="cd ~"
alias /="cd /"
alias ls="lsd"
alias ll="lsd -lah"
alias ..="cd .."
alias rm="trash-put"
alias shred-trash='find ~/.local/share/Trash/files -type f -exec shred -u {} + && rm -rf ~/.local/share/Trash/files/* ~/.local/share/Trash/info/*'
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

alias -s py=$EDITOR
alias -s c=$EDITOR
alias -s cpp=$EDITOR
alias -s h=$EDITOR
alias -s js=$EDITOR
alias -s ts=$EDITOR
alias -s json=$EDITOR
alias -s md=$EDITOR
alias -s txt=$EDITOR
alias -s xml=$EDITOR
alias -s html=$EDITOR
alias -s css=$EDITOR
alias -s rs=$EDITOR
alias -s go=$EDITOR
alias -s java=$EDITOR
alias -s lua=$EDITOR
alias -s yml=$EDITOR
alias -s yaml=$EDITOR
alias -s toml=$EDITOR
alias -s zsh=$EDITOR
alias -s fish=$EDITOR
alias -s conf=$EDITOR
alias -s ini=$EDITOR
alias -s tex=$EDITOR
alias -s nix=$EDITOR
alias -s pdf="zathura"
alias -s png="eog"
alias -s jpg="eog"
alias -s jpeg="eog"
alias -s webp="eog"
alias -s gif="eog"
alias -s svg="eog"
alias -s mp3="vlc"
alias -s mp4="vlc"
alias -s wav="vlc"
alias -s docx="libreoffice"
alias -s xlsx="libreoffice"
alias -s pptx="libreoffice"
alias -s odt="libreoffice"
alias -s ods="libreoffice"
alias -s odp="libreoffice"

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
