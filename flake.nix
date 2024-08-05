{
  description = "My NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    catppuccin.url = "github:catppuccin/nix";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, catppuccin, ... }:

  let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
  in {

    nixosConfigurations = {
      nixos-desktop = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./hosts/desktop/configuration.nix
          catppuccin.nixosModules.catppuccin
        ];
      };
    };

    homeConfigurations = {
      ecomex = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./hosts/desktop/home.nix
          catppuccin.homeManagerModules.catppuccin
        ];
      };
    };
  };
}
