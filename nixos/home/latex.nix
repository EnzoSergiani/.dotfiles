{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (texlive.combine {
      inherit (texlive)
        scheme-full
        latexindent
        latexmk;
    })
    bibtex-tidy
    ltex-ls
    zathura
  ];
}
