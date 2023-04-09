{ config, pkgs, ...} : {
  networking.hostId = "12855db8";
  networking.hostName = "pandatop";
  hardware.video.hidpi.enable=true;
}
