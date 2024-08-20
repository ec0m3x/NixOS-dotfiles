{ config,inputs, pkgs, lib, ... }:

let
  pkgs-hyprland = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in

{
  imports = [
    ./wayland.nix
    ./pipewire.nix
    ./dbus.nix
  ];

  security = {
    pam.services.login.enableGnomeKeyring = true;
  };

  services.gnome.gnome-keyring.enable = true;

  environment = {
    variables.NIXOS_OZONE_WL = "1";
    variables.MOZ_ENABLE_WAYLAND = "1";
  };

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      portalPackage = pkgs-hyprland.xdg-desktop-portal-hyprland;
      xwayland = {
        enable = true;
      };
    };
  };

  environment = {
    plasma5.excludePackages = [ pkgs.kdePackages.systemsettings ];
    plasma6.excludePackages = [ pkgs.kdePackages.systemsettings ];
  };
  services.xserver.excludePackages = [ pkgs.xterm ];

  
  xdg.portal = {
    enable = true;
      #xdgOpenUsePortal = true;
      #config = {
      #  common.default = ["hyprland"];
      #  hyprland.default = ["hyprland"];
      #};
    extraPortals = with pkgs; [
      #xdg-desktop-portal
      #xdg-desktop-portal-hyprland
    ];
  };
}
