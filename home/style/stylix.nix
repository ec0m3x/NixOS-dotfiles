{ config, pkgs, lib, inputs, userSettings, ... }:

let
  themePath = "../../../themes/"+userSettings.theme+"/"+userSettings.theme+".yaml";
  themePolarity = lib.removeSuffix "\n" (builtins.readFile (./. + "../../../themes"+("/"+userSettings.theme)+"/polarity.txt"));
  backgroundUrl = builtins.readFile (./. + "../../../themes"+("/"+userSettings.theme)+"/backgroundurl.txt");
  backgroundSha256 = builtins.readFile (./. + "../../../themes/"+("/"+userSettings.theme)+"/backgroundsha256.txt");
in

{
  imports = [ inputs.stylix.homeManagerModules.stylix ];

  home.file.".currenttheme".text = userSettings.theme;
  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = ./. + themePath;

    image = pkgs.fetchurl {
      url = backgroundUrl;
      sha256 = backgroundSha256;
    };

    polarity = themePolarity;
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
        name = "DejaVu Sans";
        package = pkgs.dejavu_fonts;
      };
      emoji = {
        name = "Noto Emoji";
        package = pkgs.noto-fonts-monochrome-emoji;
      };
      sizes = {
        terminal = 12;
        applications = 12;
        popups = 10;
        desktop = 12;
      };
    }; 
  };

  stylix.targets.alacritty.enable = false;
  programs.alacritty.settings = {
    colors = {
      # TODO revisit these color mappings
      # these are just the default provided from stylix
      # but declared directly due to alacritty v3.0 breakage
      primary.background = "#"+config.lib.stylix.colors.base00;
      primary.foreground = "#"+config.lib.stylix.colors.base07;
      cursor.text = "#"+config.lib.stylix.colors.base00;
      cursor.cursor = "#"+config.lib.stylix.colors.base07;
      normal.black = "#"+config.lib.stylix.colors.base00;
      normal.red = "#"+config.lib.stylix.colors.base08;
      normal.green = "#"+config.lib.stylix.colors.base0B;
      normal.yellow = "#"+config.lib.stylix.colors.base0A;
      normal.blue = "#"+config.lib.stylix.colors.base0D;
      normal.magenta = "#"+config.lib.stylix.colors.base0E;
      normal.cyan = "#"+config.lib.stylix.colors.base0B;
      normal.white = "#"+config.lib.stylix.colors.base05;
      bright.black = "#"+config.lib.stylix.colors.base03;
      bright.red = "#"+config.lib.stylix.colors.base09;
      bright.green = "#"+config.lib.stylix.colors.base01;
      bright.yellow = "#"+config.lib.stylix.colors.base02;
      bright.blue = "#"+config.lib.stylix.colors.base04;
      bright.magenta = "#"+config.lib.stylix.colors.base06;
      bright.cyan = "#"+config.lib.stylix.colors.base0F;
      bright.white = "#"+config.lib.stylix.colors.base07;
    };
    font.size = config.stylix.fonts.sizes.terminal;
    font.normal.family = userSettings.font;
  };
  
  stylix.targets.kde.enable = true;
  stylix.targets.kitty.enable = true;
  stylix.targets.gtk.enable = true;
  stylix.targets.feh.enable = true;
  stylix.targets.btop.enable = true;
  stylix.targets.dunst.enable = true;
  stylix.targets.firefox.enable = true;
  stylix.targets.hyprland.enable = true;
  stylix.targets.vesktop.enable = true;
  stylix.targets.vscode.enable = true;
  stylix.targets.wofi.enable = true;
  stylix.targets.swaylock.enable = true;

  gtk = {
    enable = true;
    iconTheme = {
      name = "kora";
      package = pkgs.kora-icon-theme;
    };
  };

  #home.file.".config/hypr/hyprpaper.conf".text = ''
  #  preload = ''+config.stylix.image+''

  #  wallpaper = ,''+config.stylix.image+''

  #'';

  home.packages = with pkgs; [
     libsForQt5.qt5ct pkgs.libsForQt5.breeze-qt5 libsForQt5.breeze-icons pkgs.noto-fonts-monochrome-emoji
  ];
  qt = {
    enable = true;
    style.package = pkgs.libsForQt5.breeze-qt5;
    style.name = "breeze-dark";
    platformTheme.name = "kde";
  };
  fonts.fontconfig.defaultFonts = {
    monospace = [ userSettings.font ];
    sansSerif = [ userSettings.font ];
    serif = [ userSettings.font ];
  };
}