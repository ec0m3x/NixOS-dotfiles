{ pkgs, ... }:

{
  services.logind.powerKey = "ignore";


  environment.systemPackages = with pkgs; [
    auto-cpufreq
  ];
  services.auto-cpufreq.enable = true;
}
