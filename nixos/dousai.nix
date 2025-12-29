{ config, pkgs, ... }:

let
  dotfiles = "/home/dousai/.dotfiles";
in
{
  home.username = "dousai";
  home.homeDirectory = "/home/dousai";

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "${config.home.homeDirectory}/desktop";
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/pictures";
      publicShare = "${config.home.homeDirectory}/public";
      templates = "${config.home.homeDirectory}/templates";
      videos = "${config.home.homeDirectory}/videos";
    };
  };

  home.activation.createCustomDirectories = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD mkdir -p $VERBOSE_ARG \
      ${config.home.homeDirectory}/dev/projects \
      ${config.home.homeDirectory}/dev/vm \
      ${config.home.homeDirectory}/latex
  '';

  home.packages = with pkgs; [
    # System
    baobab
    bibata-cursors
    blueman
    brightnessctl
    cava
    cliphist
    fastfetch
    git
    gnome-calculator
    gnome-disk-utility
    gnome-system-monitor
    grim
    imagemagick
    kitty
    lazygit
    lsd
    nautilus
    pavucontrol
    networkmanagerapplet
    playerctl
    slurp
    trash-cli
    wl-clipboard
    xdg-utils

    # Productivity
    discord
    inkscape
    obsidian
    signal-desktop
    texlive.combined.scheme-full
    virtualbox
    wireshark

    # Multimedia
    eog
    firefox
    libreoffice
    vlc
    zathura

    # Hyprland
    hypridle
    hyprlock
    hyprpaper
    rofi
    swaynotificationcenter
    waybar
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

  programs.git = {
    enable = true;
    userName = "EnzoSergiani";
    userEmail = "enzo.sergiani@protonmail.com";
    extraConfig = {
      credential.helper = "store";
    };
  };

  programs.neovim.enable = true;

  home.stateVersion = "25.11";
}
