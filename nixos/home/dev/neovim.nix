{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    ripgrep
    tree-sitter

    lua-language-server
    bash-language-server
    nil
    marksman
    vscode-langservers-extracted
    yaml-language-server
    pyright

    nixpkgs-fmt
    prettier
    shfmt
    stylua
    taplo
  ];
}
