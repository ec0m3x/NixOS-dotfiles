{ pkgs, userSettings, ... }:

{
  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = ~/wallpapers/apple-dark.jpg

    wallpaper = HDMI-A-1, ~/wallpapers/apple-dark.jpg
  '';
}