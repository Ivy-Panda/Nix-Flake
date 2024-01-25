{ config, impermanence, ... }: {

  environment.persistence."/persist" = {
    hideMounts = true;

    directories = [
      "/var/log"
      "/var/lib/tailscale"
    ];

    # sudo ssh-keygen -C "" -t rsa -b 4096 -f /persist/etc/ssh/ssh_host_rsa_key
    # sudo ssh-keygen -C "" -t ed25519 -f /persist/etc/ssh/ssh_host_ed25519_key
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25510_key_initrd"
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

    "/mnt" = {
      device = "tmpfs";
      fsType = "tmpfs";
      options = [ "mode=755" ];
    };
  };
}
