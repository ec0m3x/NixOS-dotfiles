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
      xwaylandvideobridge
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
  services.displayManager = {
    #autoLogin = {
    #  enable = true;
    #  user = "ecomex";
    #};
    sddm = {
      enable = true;
      package = pkgs.sddm;
      theme = "chili";
      wayland.enable = false;
      enableHidpi = false;
    };
  };
}
