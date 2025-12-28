{ config, pkgs, ... }:

let
  dotfiles = "/home/dousai/.dotfiles";
  configDirs = builtins.attrNames (builtins.readDir "${dotfiles}/config");
in
{
  home.username = "dousai";
  home.homeDirectory = "/home/dousai";

  home.file = builtins.listToAttrs (map
    (name: {
      name = ".config/${name}";
      value.source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/${name}";
    })
    configDirs);

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
    pavucontrol
    networkmanagerapplet
    playerctl
    slurp
    trash-cli
    nautilus
    wl-clipboard
    xdg-utils

    # Productivity
    discord
    obsidian
    signal-desktop
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
    initContent = builtins.readFile "${dotfiles}/config/zsh/.zshrc";
  };

  programs.git = {
    enable = true;
    userName = "EnzoSergiani";
    userEmail = "enzo.sergiani@protonmail.com";
  };

  programs.neovim.enable = true;

  home.stateVersion = "25.05";
}
