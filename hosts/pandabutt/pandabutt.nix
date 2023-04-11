{ config, pkgs, lib, ...}: {
  networking.hostId = "e25123e6";
  networking.hostName = "pandabutt";

  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
  };

  users.users."ivy".openssh.authorizedKeys.keyFiles = [ /home/ivy/.ssh/keys/authorized_keys ];

  programs.mosh.enable = true;
  networking.firewall.allowedUDPPorts = lib.mkForce [];
}
