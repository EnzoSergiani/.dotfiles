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


  home.file.".zshrc".source = "${dotfiles}/config/zsh/.zshrc";
  home.file.".gitconfig".source = "${dotfiles}/config/git/.gitconfig";

  home.file."Pictures/wallpapers".source = "${dotfiles}/wallpapers";

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    desktop = "desktop";
    downloads = "downloads";
    music = "music";
    pictures = "pictures";
    videos = "videos";
  };

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

  programs.zsh.enable = true;
  programs.git.enable = true;
  programs.neovim.enable = true;

  home.stateVersion = "25.05";
}

