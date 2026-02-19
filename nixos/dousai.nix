{ config, pkgs, ... }:

let in
{
  imports = [
    ./home/dev.nix
    ./home/hyprland.nix
    ./home/latex.nix
    ./home/media.nix
    ./home/neovim.nix
    ./home/qemu.nix
    ./home/softwares.nix
    ./home/system.nix
    ./home/terminal.nix
  ];

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

  home.stateVersion = "25.11";
}
