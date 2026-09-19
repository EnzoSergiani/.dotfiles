{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.timeout = 5;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "hid_quirks=0x045e:0x02ea:0x0004" ];
  boot.kernelModules = [ "xpad" ];
  boot.blacklistedKernelModules = [ "xpadneo" ];

  networking.hostName = "bespin";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";
  console.keyMap = "fr";
  i18n.defaultLocale = "fr_FR.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };
  services.xserver.xkb = {
    layout = "fr";
    variant = "azerty";
  };

  users.users.dousai = {
    isNormalUser = true;
    description = "Dousai";
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "docker" ];
    shell = pkgs.zsh;
  };
  services.getty.autologinUser = "dousai";

  programs.zsh.enable = true;
  programs.hyprland.enable = true;
  programs.dconf.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    curl
    tree
    wget
    usbutils
    ncdu
    brightnessctl
    gcc
    cmake
    jq
    iw
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.departure-mono
  ];

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.runAsRoot = false;
  hardware.xpadneo.enable = false;

  services.gvfs.enable = true;
  services.blueman.enable = true;
  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
    HandlePowerKeyLongPress = "ignore";
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy.AutoEnable = true;
    };
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  environment.etc."wireplumber/main.lua.d/51-bluetooth-disable-hfp.lua".text = ''
    bluez_monitor.properties = {
      ["bluez5.enable-hfp-hf"] = false,
      ["bluez5.enable-hsp-hs"] = false,
      ["bluez5.enable-msbc"] = true,
    }
  '';

  services.syncthing = {
    enable = true;
    user = "dousai";
    dataDir = "/home/dousai";
    configDir = "/home/dousai/.config/syncthing";
  };

  system.stateVersion = "26.05";
}
