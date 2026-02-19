{ pkgs, ... }:

{
  home.packages = with pkgs; [
    clang-tools
    ltex-ls
    lua-language-server
    neovim
    nixpkgs-fmt
    nodePackages.prettier
    pyright
    ripgrep
    rust-analyzer
    shfmt
    stylua
    taplo
    tree-sitter
  ];
}
