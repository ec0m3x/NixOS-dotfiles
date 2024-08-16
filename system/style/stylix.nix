{ lib, pkgs, userSettings, ... }:

let
  themePath = "${pkgs.base16-schemes}/share/themes/"+userSettings.theme+".yaml";
  themePolarity = "dark";
in

{
  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = themePath;
    polarity = themePolarity;
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
    };
  };

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

}
