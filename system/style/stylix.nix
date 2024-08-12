{ lib, pkgs, userSettings, ... }:

let
  themePath = "../../themes/"+userSettings.theme+".yaml";
  themePolarity = "dark";
in

{

  stylix.polarity = themePolarity;

  stylix.image = /home/ecomex/wallpapers/apple-dark.jpg;

  stylix.base16Scheme = themePath;
  stylix.fonts = {
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
      name = "Noto Color Emoji";
      package = pkgs.noto-fonts-emoji-blob-bin;
    };
  };

  stylix.targets.gtk.enable = true;
}
