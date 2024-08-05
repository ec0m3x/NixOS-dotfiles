{ config, pkgs, ... }:

let
  myAliases = {
    ll = "ls -la";
    ".." =  "cd ..";
  };
in

{
  programs = {
    zsh = {
      enable = true;
      shellAliases = myAliases;
    };
    bash = {
      enable = true;
      shellAliases = myAliases;
    };
  };
}
