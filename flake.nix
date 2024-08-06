{
  description = "My NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, catppuccin, ... }:

  let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = import nixpkgs-unstable {inherit system; config.allowUnfree = true; };
  in {

    nixosConfigurations = {
      nixos-desktop = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./hosts/desktop/configuration.nix
          catppuccin.nixosModules.catppuccin
        ];
        specialArgs = {
          inherit pkgs-unstable;
        };
      };
    };

    homeConfigurations = {
      ecomex = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./hosts/desktop/home.nix
          catppuccin.homeManagerModules.catppuccin
        ];
        extraSpecialArgs = {
          inherit pkgs-unstable;
        };
      };
    };
  };
}
