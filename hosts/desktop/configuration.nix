# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../system/hardware/bluetooth.nix
      ../../system/hardware/zram.nix
      ../../system/hardware/graphics.nix
      ../../system/hardware/xbox-controller.nix
      ../../system/hardware/kernel.nix
      ../../system/hardware/printing.nix
      ../../system/hardware/openrgb.nix
      ../../system/hardware/power.nix
      ../../system/wm/hyprland.nix
      ../../system/app/virtualisation.nix
      ../../system/app/gaming.nix
      ../../system/app/flatpak.nix
      ../../system/security/gpg.nix
      ../../system/security/automount.nix
      ../../system/security/tailscale.nix
      ../../system/style/stylix.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-desktop";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "de";

  users.users.ecomex = {
    isNormalUser = true;
    description = "ecomex";
    initialPassword = "geheim";
    extraGroups = [ "networkmanager" "wheel" "input" "dialout" "libvirtd" "kvm" "gamemode"];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    zsh
    curl
    git
    nfs-utils
    home-manager
    nh
    nix-output-monitor
    nvd
  ];

  environment.sessionVariables = {
    FLAKE = "/home/ecomex/dotfiles";
  };

  # I use zsh
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  fonts.fontDir.enable = true;

  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
