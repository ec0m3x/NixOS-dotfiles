{ config, pkgs, ... }:
  
  {
    # Nextcloud client
    home.packages = with pkgs; [
      nextcloud-client
    ];

    services.nextcloud-client = {
      enable = true;
    };
  }
  
