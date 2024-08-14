{ config, pkgs, pkgs-unstable, lib, ... }:

{

  programs.vscode = {
    enable = true;
    package = pkgs-unstable.vscode;
    enableUpdateCheck = false;
    userSettings = {
      "files.autoSave" = "on";
      "[nix]"."editor.tabSize" = 2;
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
