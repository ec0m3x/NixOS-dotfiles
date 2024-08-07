{ config, pkgs, pkgs-unstable, ... }:

{
  imports =
    [ ../../home/shell/sh.nix
      ../../home/wm/hyprland/hyprland.nix
      ../../home/hardware/bluetooth.nix
      ../../home/shell/cli-collection.nix
      ../../home/style/style.nix
      ../../home/app/git/git.nix
      ../../home/app/development/vscode.nix
      ../../home/app/cloud/nextcloud-client.nix
    ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ecomex";
  home.homeDirectory = "/home/ecomex";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = [
    # Core
    pkgs.zsh
    pkgs.firefox
    pkgs.git

    # Office
    pkgs.libreoffice-fresh
    
    # Gnome stuff
    pkgs.gnome.adwaita-icon-theme
    pkgs.gnome.nautilus
    pkgs.gnome.seahorse
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
    pkgs.gnome.cheese
    pkgs.spotify

    # Communication
    pkgs-unstable.webcord
    pkgs-unstable.betterdiscord-installer
    pkgs-unstable.geary
  ];


  home.sessionVariables = {
    EDITOR = "vscode";
    BROWSER = "firefox";

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
  

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
