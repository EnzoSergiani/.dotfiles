{ config, pkgs, ... }:

let
  dotfiles = "/home/dousai/.dotfiles";

  zen-browser-pkg = builtins.fetchTarball {
    url = "https://github.com/0xc000022070/zen-browser-flake/archive/main.tar.gz";
  };
  zen-browser = (pkgs.callPackage zen-browser-pkg { }).default;

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
    # === Terminal & CLI Tools ===
    fastfetch
    kitty
    lsd
    trash-cli
    unzip

    # === System Utilities ===
    baobab
    blueman
    brightnessctl
    fprintd
    gnome-calculator
    gnome-disk-utility
    gnome-system-monitor
    libfprint
    nautilus
    pavucontrol
    usbutils

    # === Clipboard & Screenshots ===
    cliphist
    grim
    slurp
    wl-clipboard
    xdg-utils

    # === Theming & UI ===
    adwaita-icon-theme
    bibata-cursors
    kdePackages.qtsvg

    # === Hyprland Ecosystem ===
    hypridle
    hyprlock
    hyprpaper
    rofi
    swaynotificationcenter
    waybar

    # === Multimedia ===
    cava
    cheese
    eog
    imagemagick
    inkscape
    playerctl
    vlc
    zathura

    # === Productivity ===
    libreoffice
    obsidian
    virtualbox
    wireshark
    zen-browser

    # === Communication ===
    discord
    signal-desktop
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
    settings = {
      user = {
        email = "enzo.sergiani@protonmail.com";
        name = "EnzoSergiani";
      };
      credential.helper = "store";
    };
  };

  programs.neovim.enable = true;

  home.stateVersion = "25.11";
}
