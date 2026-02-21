{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  # === Nix ===
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # === Boot ===
  boot.loader.systemd-boot.enable = true;
  boot.loader.timeout = 5;
  boot.loader.efi.canTouchEfiVariables = true;

  # === Network ===
  networking.hostName = "bespin";
  networking.networkmanager.enable = true;

  # === Localisation ===
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

  # === Users ===
  users.users.dousai = {
    isNormalUser = true;
    description = "Dousai";
    extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
    shell = pkgs.zsh;
  };

  # === System programs ===
  programs.hyprland.enable = true;
  programs.zsh.enable = true;
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
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # === Services ===
  services.gvfs.enable = true;
  services.blueman.enable = true;
  services.getty.autologinUser = "dousai";

  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
    HandlePowerKeyLongPress = "ignore";
  };

  # === Bluetooth ===
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  # === Audio ===
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

  # === Virtualisation ===
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.runAsRoot = false;

  # === Xbox controller ===
  hardware.xpadneo.enable = false;
  boot.kernelParams = [ "hid_quirks=0x045e:0x02ea:0x0004" ];
  boot.kernelModules = [ "xpad" ];
  boot.blacklistedKernelModules = [ "xpadneo" ];

  # === System ===
  system.stateVersion = "25.11";
}
