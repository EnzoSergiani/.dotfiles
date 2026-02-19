{
  description = "Python development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        python = pkgs.python312;
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            python
            python.pkgs.pip
            python.pkgs.virtualenv
            pyright
            black
            python.pkgs.ipython
          ];

          nativeBuildInputs = with pkgs; [
            gcc
            pkg-config
          ];

          shellHook = ''
            echo "🐍 $(python --version)"

            if [ ! -d .venv ]; then
              echo "→ Creating .venv..."
              python -m venv .venv
            fi

            source .venv/bin/activate

            if [ -f requirements.txt ]; then
              pip install -r requirements.txt --quiet
            fi

            echo "✓ venv activated: $(which python)"
          '';
        };
      });
}
