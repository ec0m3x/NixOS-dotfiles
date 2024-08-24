{ config, pkgs, ... }:

let
  myAliases = {
    ll = "eza --icons=auto -la";
    ls = "eza --icons=auto";
    ".." =  "cd ..";
    full-rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles/ && home-manager switch --flake ~/dotfiles/";
    full-clean = "sudo nix-collect-garbage --delete-old && nix-collect-garbage --delete-old";
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
