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
    };
  };
  xdg.portal = {
    enable = true;
      xdgOpenUsePortal = true;
      config = {
        common.default = ["hyprland"];
        hyprland.default = ["hyprland"];
      };
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-hyprland
    ];
  };
}
