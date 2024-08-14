{ config, lib, pkgs, inputs, ... }:

{

  programs.feh.enable = true;

  home.packages = with pkgs; [
    libsForQt5.qt5ct
    libsForQt5.breeze-qt5
    libsForQt5.breeze-icons
    noto-fonts-monochrome-emoji
    quintom-cursor-theme
  ];

  home.pointerCursor = {
    gtk.enable = true;
    name = "Quintom_Ink";
    package = pkgs.quintom-cursor-theme;
    size = 24;
  };

  dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
  };

  #catppuccin = {
  #  enable = true;
  #  flavor = "mocha";
  #  accent = "blue";
    #pointerCursor = {
    #  enable = true;
    #  accent = "dark";
    #  flavor = "mocha";
    #};

  #};

  gtk = {
    enable = true;
  #  catppuccin = {
  #    enable = true;
  #    flavor = "mocha";
  #    accent = "blue";
  #  };
    iconTheme = {
      #name = "Papirus-Dark";
      name = "kora";
      #package = pkgs.papirus-icon-theme;
      package = pkgs.kora-icon-theme;
    };
    #font = {
      #name = "JetBrains Mono Medium";
      #name = "FiraCode Nerd Font Mono Medium";
    #};
  #  cursorTheme = {
  #    name = "Catppuccin-Mocha-Dark";
  #    package = pkgs.catppuccin-cursors.mochaDark;
  #    size = 16;
  #  };
  };


  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = ~/wallpapers/apple-dark.jpg

    wallpaper = HDMI-A-1, ~/wallpapers/apple-dark.jpg
  '';
  
  qt = {
    enable = true;
    style.package = pkgs.libsForQt5.breeze-qt5;
    style.name = "kvantum";
    platformTheme.name = "kvantum";
  };
}
