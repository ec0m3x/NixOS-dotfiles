{ config, pkgs-unstable, ... }:
  
  {
    # Nextcloud client
    home.packages = with pkgs-unstable; [
      nextcloud-client
    ];

    services.nextcloud-client = {
      enable = true;
      package = pkgs-unstable.nextcloud-client;
    };
  }
  
