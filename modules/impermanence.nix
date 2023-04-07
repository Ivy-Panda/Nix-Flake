{ config, impermanence, ...}: {

  environment.persistence."/persist" = {
    hideMounts = true;

    directories = [
      "/var/log"
    ];

    files = [
      "/etc/machine-id"
    ];
  };

  environment.etc."NetworkManager/system-connections".source = 
  "/persist/etc/NetworkManager/system-connections";

  fileSystems = {
    "/" = {
      device = "tmpfs";
      fsType = "tmpfs";
      options = [ "mode=755" ];
    };

    "/boot" = { device = "/dev/disk/by-partlabel/_efi";};

    "/nix" = {
      device = "tank/nix";
      fsType = "zfs";
    };

    "/persist" = {
      device = "tank/persist";
      fsType = "zfs";
      neededForBoot = true;
    };

    "/home" = {
      device = "tank/persist/home";
      fsType = "zfs";
    };
  };
}
