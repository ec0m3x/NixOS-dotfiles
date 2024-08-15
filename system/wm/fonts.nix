{ pkgs, ... }:

{
  # Fonts
  fonts.packages = with pkgs; [
    nerdfonts
    font-awesome
    font-awesome_5
    intel-one-mono
  ];
}
