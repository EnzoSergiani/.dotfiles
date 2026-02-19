{
  description = "C++ development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            gcc
            clang
            clang-tools
            cmake
            ninja
            pkg-config
            gdb
            valgrind
          ];

          shellHook = ''
            echo "⚙️  C++ — $(g++ --version | head -1)"

            if [ -f CMakeLists.txt ] && [ ! -d build ]; then
              cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug \
                -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
              ln -sf build/compile_commands.json compile_commands.json
            fi
          '';
        };
      });
}
