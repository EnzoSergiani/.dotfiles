{ config, pkgs, ... }:

let
  dotfiles = "/home/dousai/.dotfiles";
in
{
  home.packages = with pkgs; [
    btop
    fastfetch
    kitty
    lsd
    ncdu
    trash-cli
    unzip
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "enzo.sergiani@protonmail.com";
        name = "EnzoSergiani";
      };
      credential.helper = "store";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    silent = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      source ${dotfiles}/config/zsh/.zshrc
    '';
    profileExtra = ''
      if [[ -z "$WAYLAND_DISPLAY" && "$(tty)" == "/dev/tty1" ]]; then
        exec start-hyprland
      fi
    '';
    dotDir = config.home.homeDirectory;
  };
}
