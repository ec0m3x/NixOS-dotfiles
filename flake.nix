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

    hyprland = {
      type = "git";
      url = "https://code.hyprland.org/hyprwm/Hyprland.git";
      submodules = true;
      rev = "c7b72790bd63172f04ee86784d4cb2a400532927"; #v0.42.0
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      type = "git";
      url = "https://code.hyprland.org/hyprwm/hyprland-plugins.git";
      rev = "b73d7b901d8cb1172dd25c7b7159f0242c625a77"; #v0.42.0
      inputs.hyprland.follows = "hyprland";
    };
    hyprlock = {
      type = "git";
      url = "https://code.hyprland.org/hyprwm/hyprlock.git";
      rev = "58e1a4a4997728be886a46d031514b3f09763c5d";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager-stable, home-manager-unstable, stylix, hyprland, hyprland-plugins, hyprlock, ... }:

  let
      # --- System Settings --- #
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };
      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };

      home-manager = home-manager-unstable;

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
          stylix.nixosModules.stylix
        ];
        specialArgs = {
          inherit pkgs-stable;
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
          inherit pkgs-stable;
          inherit userSettings;
        };
      };
    };
  };
}
