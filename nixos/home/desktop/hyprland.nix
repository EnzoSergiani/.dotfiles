{ pkgs, ... }:

{
  home.packages = with pkgs; [
    adwaita-icon-theme
    bibata-cursors
    cliphist
    grim
    hypridle
    hyprlock
    hyprpaper
    kdePackages.qtsvg
    playerctl
    rofi
    slurp
    swaynotificationcenter
    waybar
    wl-clipboard
    xdg-utils
  ];
}
