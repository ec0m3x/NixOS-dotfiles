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
      (sddm-chili-theme.override {
        themeConfig = {
          background = config.stylix.image;
          ScreenWidth = 3440;
          ScreenHeight = 1440;
          blur = true;
          recursiveBlurLoops = 3;
          recursiveBlurRadius = 5;
        };})
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
    sddm = {
      enable = true;
      package = pkgs.sddm;
      theme = "chili";
      wayland.enable = true;
      enableHidpi = true;
    };
  };
}
