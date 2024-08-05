{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    vscode
  ];
  programs.vscode = {
    enable = true;
    enableUpdateCheck = true;
  };

  nixpkgs.config = {
  allowUnfree = true;
  allowUnfreePredicate = (_: true);
  };

  
}
