{ config, pkgs, pkgs-stable, inputs, userSettings, ... }:

{
  imports =
    [ ../../home/shell/sh.nix
      ../../home/wm/hyprland/hyprland.nix
      ../../home/hardware/bluetooth.nix
      ../../home/shell/cli-collection.nix
      ../../home/style/stylix.nix
      ../../home/app/git/git.nix
      ../../home/app/development/vscode.nix
      ../../home/app/cloud/nextcloud-client.nix
      (./. + "../../../home/app/browser"+("/"+userSettings.browser)+".nix")
    ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ecomex";
  home.homeDirectory = "/home/ecomex";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = [
    # Core
    pkgs.zsh
    pkgs.git

    # Office
    pkgs.libreoffice-fresh
    
    # Gnome stuff
    pkgs.adwaita-icon-theme
    pkgs.nautilus
    pkgs.seahorse
    pkgs.gnome.gnome-maps

    # Media
    pkgs.vlc
    pkgs.gimp
    pkgs.mpv
    pkgs.yt-dlp
    pkgs.obs-studio
    pkgs.ffmpeg
    pkgs.movit
    pkgs.mediainfo
    pkgs.libmediainfo
    pkgs.cheese
    pkgs.spotify

    # Communication
    #pkgs.webcord
    pkgs.discord
    pkgs.vesktop
    pkgs.geary
  ];


  home.sessionVariables = {
    EDITOR = "vscode";
    BROWSER = userSettings.browser;

  };

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    music = "${config.home.homeDirectory}/Media/Music";
    videos = "${config.home.homeDirectory}/Media/Videos";
    pictures = "${config.home.homeDirectory}/Media/Pictures";
    templates = "${config.home.homeDirectory}/Templates";
    download = "${config.home.homeDirectory}/Downloads";
    documents = "${config.home.homeDirectory}/Documents";
    desktop = null;
    publicShare = null;
    extraConfig = {
      XDG_DOTFILES_DIR = "${config.home.homeDirectory}/dotfiles";
      XDG_ARCHIVE_DIR = "${config.home.homeDirectory}/Archive";
      XDG_VM_DIR = "${config.home.homeDirectory}/Machines";
      XDG_ORG_DIR = "${config.home.homeDirectory}/Org";
      XDG_PODCAST_DIR = "${config.home.homeDirectory}/Media/Podcasts";
      XDG_BOOK_DIR = "${config.home.homeDirectory}/Media/Books";
    };
  };
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  xdg.mimeApps.associations.added = {
    "image/jpeg" = "feh.desktop";
    "image/png" = "feh.desktop";
  };

  news.display = "silent";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
