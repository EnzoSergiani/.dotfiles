{ config, pkgs, ... }:

let
  dotfiles = "/home/dousai/.dotfiles";
  configDirs = builtins.attrNames (builtins.readDir "${dotfiles}/config");
in
{
  home.username = "dousai";
  home.homeDirectory = "/home/dousai";

  home.file = builtins.listToAttrs (map (name: {
    name = ".config/${name}";
    value.source = "${dotfiles}/config/${name}";
  }) configDirs);

  home.packages = with pkgs; [
    btop
    cava
    discord
    fastfetch
    firefox
    hypridle
    hyprlock
    hyprpaper
    kitty
    lazygit
    lsd
    nautilus
    ncdu
    obsidian
    playerctl
    rofi
    signal-desktop
    swaynotificationcenter
    virtualbox
    waybar
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = builtins.readFile "${dotfiles}/config/zsh/.zshrc";
  };
  programs.git = {
    enable = true;
    userName  = "EnzoSergiani";
    userEmail = "enzo.sergiani@protonmail.com";
  };

  programs.neovim.enable = true;

  home.stateVersion = "25.05";
}

