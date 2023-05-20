{ config, pkgs, lib, ...}: {
  networking = {
    hostId = "e25123e6";
    hostName = "pandabutt";
    firewall.allowedUDPPortRanges = [{ from = 60001; to = 60010; }];
  };

  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
  };

  users.users."ivy".openssh.authorizedKeys.keys = import ./modules/authorized_keys;

  environment.systemPackages = with pkgs; [
    weechat
    certbot
  ];
}
