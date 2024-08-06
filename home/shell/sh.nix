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
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      history.size = 100000;
      oh-my-zsh = {
        enable = true;
        plugins = [ "extract" "git" "sudo" ];
        theme = "dst";
      };
    };
    bash = {
      enable = true;
      shellAliases = myAliases;
    };
  };
}
