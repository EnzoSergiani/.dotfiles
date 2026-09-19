{ config, pkgs, ... }:

{
  imports = [
    ./home/core/shell.nix
    ./home/core/xdg.nix
    ./home/desktop/hyprland.nix
    ./home/desktop/media.nix
    ./home/dev/neovim.nix
    ./home/dev/tools.nix
    ./home/apps/softwares.nix
    ./home/apps/system.nix
    ./home/apps/retroarch.nix
    ./home/apps/qemu.nix
  ];

  home.username = "dousai";
  home.homeDirectory = "/home/dousai";
  home.stateVersion = "25.11";
}
