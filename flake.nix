{
  description = "My NixOS";

  inputs = {
    nixpkgs-stable.url = "nixpkgs/nixos-24.05";
    nixpkgs.url = "nixpkgs/nixos-unstable";

    stylix.url = "github:danth/stylix";

    home-manager-stable.url = "github:nix-community/home-manager/release-24.05";
    home-manager-stable.inputs.nixpkgs.follows = "nixpkgs-stable";

    home-manager-unstable.url = "github:nix-community/home-manager/master";
    home-manager-unstable.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };

  #outputs = { self, nixpkgs, nixpkgs-stable, home-manager-stable, home-manager-unstable, stylix, hyprland, ... }:
  outputs = {self, ... }@inputs:
  let
      # --- System Settings --- #
      lib = inputs.nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };
      pkgs-stable = import inputs.nixpkgs-stable {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };

      home-manager = inputs.home-manager-unstable;

      # --- User Settings --- #
      userSettings = rec {
        username = "ecomex";
        name = "Sebastian";
        email = "skoch@sks-concept.de";
        browser = "firefox";
        theme = "catppuccin-mocha";
        wallpaper ="hyprland.jpg"; # pick one of themes/wallpapers
        font = "Intel One Mono";
        fontPkg = pkgs.intel-one-mono;
      };

  in {

    nixosConfigurations = {
      nixos-desktop = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./hosts/desktop/configuration.nix
          inputs.stylix.nixosModules.stylix
        ];
        specialArgs = {
          #inherit pkgs-stable;
          inherit inputs;
          inherit userSettings;
        };
      };
    };

    homeConfigurations = {
      ecomex = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./hosts/desktop/home.nix
          inputs.stylix.homeManagerModules.stylix
        ];
        extraSpecialArgs = {
          #inherit pkgs-stable;
          inherit inputs;
          inherit userSettings;
        };
      };
    };
  };
}
