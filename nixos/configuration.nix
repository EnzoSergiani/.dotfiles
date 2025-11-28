{ config, lib, pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./dousai.nix    
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "bespin";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "fr_FR.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME = "fr_FR.UTF-8";
  };

  console.keyMap = "fr";

  services.xserver.xkb = {
    layout = "fr";
    variant = "azerty";
  };

  users.users.dousai = {
    isNormalUser = true;
    extraGroups = [ "wheel", "networkmanager" ];
    shell = pkgs.zsh;
  };home-manager.users.dousai = import "/home/dousai/.dotfiles/nixos/dousai.nix";

  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    curl
    tree
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  system.stateVersion = "25.05";

  home-manager.users.dousai = import "/home/dousai/.dotfiles/nixos/dousai.nix";
}

