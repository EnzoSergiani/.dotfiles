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

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      source ${dotfiles}/config/zsh/.zshrc
    '';
  };
}
