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
      "workbench.iconTheme" = "catppuccin-mocha";
      "window.menuBarVisibility" = "toggle";
      "window.density.editorTabHeight" = "compact";
      "git.enableSmartCommit" = true;
      "git.confirmSync" = false;
    };
  };

  nixpkgs.config = {
  allowUnfree = true;
  allowUnfreePredicate = (_: true);
  };
}
