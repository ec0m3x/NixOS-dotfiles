{ ... }:

{
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  programs.gnome-disks.enable = true;


  boot.supportedFilesystems = [ "cifs" ];

  systemd.mounts = [{
    description = "Mount for SMB Share";
    what = "//192.168.0.31/homestorage/";
    where = "/home/ecomex/HomeStorage";
    type = "cifs";
    options = "credentials=/home/ecomex/.smbcredentials/ecomex-smb,rw,uid=1000,gid=1000";
    }];

  systemd.automounts = [{
    description = "Automount for SMB Share";
    where = "/home/ecomex/HomeStorage";
    wantedBy = [ "multi-user.target" ];
  }];
  
  fileSystems."/home/ecomex/Devices/SSD1-250GB" = {
    device = "/dev/disk/by-uuid/5ee2439c-1e49-4604-8181-57cd84353879";
    fsType = "auto";
    options = [ "noatime" "nosuid" "nodev" "nofail" "x-gvfs-show"]; # Optional, similar to mount options in fstab
  };

  fileSystems."/home/ecomex/Devices/SSD2-250GB" = {
    device = "/dev/disk/by-uuid/dda96545-99d1-44cb-ae86-1eed285e96d5";
    fsType = "auto";
    options = [ "noatime" "nosuid" "nodev" "nofail" "x-gvfs-show"]; # Optional, similar to mount options in fstab
  };

  fileSystems."/home/ecomex/Devices/SSD3-512GB" = {
    device = "/dev/disk/by-uuid/fbe144f6-105d-49a7-9bcb-2f2f83c1858f";
    fsType = "auto";
    options = [ "noatime" "nosuid" "nodev" "nofail" "x-gvfs-show"]; # Optional, similar to mount options in fstab
  };

  fileSystems."/home/ecomex/NFS" = {
    device = "192.168.0.31:/mnt/TANK/Docker-NFS";
    fsType = "nfs";
    options = [ "rw" "x-systemd.automount" "x-systemd.requires=network-online.target" "x-systemd.device-timeout=10s" ];
  };
}