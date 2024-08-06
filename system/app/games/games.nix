{ pkgs, ... }:

{

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  programs = {
    steam.enable = true;
    gamemode.enable = true;
  };
}

