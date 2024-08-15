{ config, pkgs, ... }:

{
  # Enable the Tailscale service
  services.tailscale = {
    enable = true;
    package = pkgs.tailscale;
    useRoutingFeatures = "both";
    authKeyFile = "/home/ecomex/.tailscale/auth-key";
  };
}

