{ lib, pkgs, userSettings, ... }:

let
  themePath = "../../themes/"+userSettings.theme+".yaml";
  themePolarity = "dark";
in

{

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    polarity = "dark";
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
  };
}
