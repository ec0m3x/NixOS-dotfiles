{ pkgs, ... }:

{

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };

  # hardware.opengl has beed changed to hardware.graphics in unstable branch

  #services.xserver.videoDrivers = ["amdgpu"];

}
