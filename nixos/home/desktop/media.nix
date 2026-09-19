{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cava
    cheese
    darktable
    eog
    gimp3-with-plugins
    imagemagick
    inkscape
    vlc
    zathura
  ];
}
