{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lazygit
    nodejs
    python3
    black
  ];
}
