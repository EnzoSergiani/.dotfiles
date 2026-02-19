{
  description = "Bespin NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, ... }: {
    nixosConfigurations.bespin = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inherit zen-browser;
        inputs = { inherit nixpkgs home-manager zen-browser; };
        hardwareConfig = /etc/nixos/hardware-configuration.nix;
      };

      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.dousai = import ./dousai.nix;
          home-manager.extraSpecialArgs = { inherit zen-browser; };
        }
      ];
    };
  };
}
