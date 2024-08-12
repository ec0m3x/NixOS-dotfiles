{ ... }:

{
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  programs.gnome-disks.enable = true;


  boot.supportedFilesystems = [ "cifs" ];

  systemd.mounts = [{
    description = "Mount for SMB Share";
    what = "//192.168.0.30/ecomex-storage/";
    where = "/home/ecomex/ecomex-storage";
    type = "cifs";
    options = "credentials=/home/ecomex/.smb/credentials-ecomex-storage,rw,uid=1000,gid=1000";
    }];

  systemd.automounts = [{
    description = "Automount for SMB Share";
    where = "/home/ecomex/ecomex-storage";
    wantedBy = [ "multi-user.target" ];
  }];
  
  fileSystems."/home/ecomex/Devices/250-GB-SSD" = {
    device = "/dev/disk/by-uuid/91b1ecb5-bae3-4f64-b4f0-094a06624c81";
    fsType = "auto";
    options = [ "noatime" "nosuid" "nodev" "nofail" "x-gvfs-show"]; # Optional, similar to mount options in fstab
  };
}