{ pkgs, ... }:

{
  home.packages = with pkgs; [
    baobab
    gnome-calculator
    gnome-disk-utility
    gnome-system-monitor
    nautilus
    pamixer
    pavucontrol
  ];
}
