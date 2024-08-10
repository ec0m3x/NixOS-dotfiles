{ config, pkgs, ... }:

{
  # Enable the Tailscale service
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";

  };
}

