{ config, pkgs, ... }:

{
  imports =
    [ ../../home/shell/sh.nix
      ../../home/wm/hyprland/hyprland.nix
      ../../home/hardware/bluetooth.nix
      ../../home/shell/cli-collection.nix
      ../../home/style/style.nix
      ../../home/app/git/git.nix
    ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ecomex";
  home.homeDirectory = "/home/ecomex";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # Core
    zsh
    firefox
    brave
    git

    # Office
    libreoffice-fresh
    
    # Gnome stuff
    gnome.adwaita-icon-theme
    gnome.nautilus
    gnome.seahorse
    gnome.gnome-maps

    # Media
    vlc
    gimp
    mpv
    yt-dlp
    obs-studio
    ffmpeg
    movit
    mediainfo
    libmediainfo
    gnome.cheese
    spotify

    # Communication
    webcord
  ];

  home.file = {
  };

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
