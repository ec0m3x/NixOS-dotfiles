{
  description = "My NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, stylix, ... }:

  let
      # --- System Settings --- #
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = import nixpkgs-unstable {inherit system; config.allowUnfree = true; };

      # --- User Settings --- #
      userSettings = rec {
        username = "ecomex";
        name = "Sebastian";
        email = "skoch@sks-concept.de";
        theme = "catppuccin-mocha";
        font = "Intel One Mono";
        fontPkg = pkgs.intel-one-mono;
      };

  in {

    nixosConfigurations = {
      nixos-desktop = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./hosts/desktop/configuration.nix
          stylix.nixosModules.stylix
        ];
        specialArgs = {
          inherit pkgs-unstable;
          inherit userSettings;
        };
      };
    };

    homeConfigurations = {
      ecomex = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./hosts/desktop/home.nix
          stylix.homeManagerModules.stylix
        ];
        extraSpecialArgs = {
          inherit pkgs-unstable;
          inherit userSettings;
        };
      };
    };
  };
}
