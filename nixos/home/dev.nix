{ pkgs, ... }:

{
  home.packages = with pkgs; [
    black
    cargo
    clang-tools
    lazygit
    nixpkgs-fmt
    nodejs
    nodePackages.prettier
    python3
    rust-analyzer
    rustc
    rustfmt
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
