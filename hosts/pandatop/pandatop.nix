{ config, pkgs, ...} : {
  networking.hostId = "12855db8";
  networking.hostName = "pandatop";
  
  # Force intel graphics driver to be loaded
  boot.kernelParams = [ "i915.force_probe=46a6" ];
}
