{ pkgs, ... }:

{
  home.packages = with pkgs; [
    black
    lazygit
    nixpkgs-fmt
    nodejs
    nodePackages.prettier
    python3
    shfmt
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "enzo.sergiani@protonmail.com";
        name = "EnzoSergiani";
      };
      credential.helper = "store";
    };
  };
}
