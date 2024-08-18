{ config, pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.consoleLogLevel = 0;

  ## Enable Wifi driver

  boot.kernelModules = [ "88x2bu" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    rtl88x2bu
  ];
  environment.systemPackages = [
    pkgs.linuxKernel.packages.linux_xanmod_latest.rtl88x2bu
  ];
}
