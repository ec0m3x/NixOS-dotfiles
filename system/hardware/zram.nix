{ pkgs, ...}:
{
  # Enable zram
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    #memoryMax = 20;
    memoryPercent = 20;
  };
}