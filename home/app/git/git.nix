{ config, pkgs, ... }:

{
  home.packages = [ pkgs.git ];
  programs.git.enable = true;
  programs.git.userName = "ecomex";
  programs.git.userEmail = "skoch@sks-concept.de";
  programs.git.extraConfig = {
    init.defaultBranch = "main";
  };
}
