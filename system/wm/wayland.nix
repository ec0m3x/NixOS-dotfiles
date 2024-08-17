{ config, pkgs, ... }:

{
  imports = 
    [ ./pipewire.nix
      ./dbus.nix
      ./gnome-keyring.nix
      ./fonts.nix
    ];
  environment.systemPackages = with pkgs;
    [
      wayland
      sddm-chili-theme
    ];

  # Configure xwayland
  services.xserver = {
    enable = true;
    xkb = {
      layout = "de";
      variant = "";
    };
  };
  
  # Configure SDDM
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.sddm;
    theme = "chili";
    wayland.enable = true;
    enableHidpi = true;
  };
}
