{
  description = "Typst development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        fontsConf = pkgs.makeFontsConf {
          fontDirectories = [
            "${pkgs.font-awesome}/share/fonts/opentype"
            "${pkgs.font-awesome}/share/fonts/truetype"
          ];
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            typst
            typstyle
            tinymist
            font-awesome
          ];

          FONTCONFIG_FILE = fontsConf;

          shellHook = ''
            echo "📝 Typst $(typst --version)"
          '';
        };
      });
}
