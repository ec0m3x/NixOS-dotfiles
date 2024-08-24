{
  description = "My NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager-unstable.url = "github:nix-community/home-manager/master";
    home-manager-unstable.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

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
      pkgs-unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };
      home-manager = inputs.home-manager;

      # --- User Settings --- #
      userSettings = rec {
        username = "ecomex"; # Your username;
        name = "Sebastian"; # Your name;
        email = "skoch@sks-concept.de"; # Your email;
        browser = "firefox"; # Default browser command;
        term = "alacritty"; # Default terminal command;
        theme = "horizon-dark"; # Default theme;
        font = "Intel One Mono"; # Default font;
        fontPkg = pkgs.intel-one-mono; # Default font package;
      };

  in {

    nixosConfigurations = {
      nixos-desktop = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./hosts/desktop/configuration.nix
        ];
        specialArgs = {
          inherit inputs;
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
        ];
        extraSpecialArgs = {
          inherit inputs;
          inherit pkgs-unstable;
          inherit userSettings;
        };
      };
    };
  };
}
