{ config, pkgs, lib, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    enableUpdateCheck = false;
    userSettings = {
      "files.autoSave" = "onFocusChange";
      "[nix]"."editor.tabSize" = 2;
      "window.menuBarVisibility" = "toggle";
      "window.density.editorTabHeight" = "default";
      "git.enableSmartCommit" = true;
      "git.confirmSync" = false;
      "workbench.startupEditor" = "none";
    };
  };

  nixpkgs.config = {
  allowUnfree = true;
  allowUnfreePredicate = (_: true);
  };
}
