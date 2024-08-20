{ config, pkgs, pkgs-unstable, ... }:

{
  # Enable the Tailscale service
  services.tailscale = {
    enable = true;
    package = pkgs-unstable.tailscale;
    useRoutingFeatures = "both";
    authKeyFile = "/home/ecomex/.tailscale/auth-key";
  };
}

