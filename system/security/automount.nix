{ ... }:

{
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  programs.gnome-disks.enable = true;

  # Enable the systemd automount service

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
}