{ pkgs, zen-browser, ... }:

{
  home.packages = with pkgs; [
    discord
    libreoffice
    obsidian
    signal-desktop
    zen-browser.packages.x86_64-linux.default
  ];
}
