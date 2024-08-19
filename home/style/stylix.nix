{ config, pkgs, lib, inputs, userSettings, ... }:


  let
    themePath = "${pkgs.base16-schemes}/share/themes/"+userSettings.theme+".yaml";
    themePolarity = "dark";
    wallpaper = userSettings.wallpaper;
  in

{  
  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = themePath;
    image = ../../theme/wallpapers/${wallpaper};
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

  stylix.targets.alacritty.enable = true;
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