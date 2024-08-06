{ config, pkgs, pkgs-unstable, lib, ... }:

{
  home.packages = with pkgs; [
    vscode
  ];
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    userSettings = {
      "files.autoSave" = "on";
      "[nix]"."editor.tabSize" = 2;
      "workbench.colorTheme" = "Catppuccin Mocha";
      "window.menuBarVisibility" = "toggle";
      "window.density.editorTabHeight" = "compact";
    };
  };

  nixpkgs.config = {
  allowUnfree = true;
  allowUnfreePredicate = (_: true);
  };
  
}
