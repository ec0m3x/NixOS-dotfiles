{ config, pkgs, lib, ... }:

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
  };

  programs = {
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
      };
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
  };

  


}
