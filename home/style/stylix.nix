{ pkgs, lib, inputs, userSettings, ... }:

{

  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/"+userSettings.theme+".yaml";
    image = ../../theme/wallpapers/hyprland.jpg;
    polarity = "dark";
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
    fonts = {
      monospace = {
        name = userSettings.font;
        package = userSettings.fontPkg;
      };
      serif = {
        name = userSettings.font;
        package = userSettings.fontPkg;
      };
      sansSerif = {
        name = userSettings.font;
        package = userSettings.fontPkg;
      };
      emoji = {
        name = "Noto Emoji";
        package = pkgs.noto-fonts-monochrome-emoji;
      };
      sizes = {
        terminal = 18;
        applications = 12;
        popups = 12;
        desktop = 12;
      };
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "kora";
      package = pkgs.kora-icon-theme;
    };
  };
}