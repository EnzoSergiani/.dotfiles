{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lua-language-server
    neovim
    nixpkgs-fmt
    nodePackages.prettier
    pyright
    ripgrep
    shfmt
    stylua
    taplo
    tree-sitter
  ];
}
