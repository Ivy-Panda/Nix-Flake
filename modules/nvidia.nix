{ config, pkgs, ...}: {

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;
  hardware.opengl.enable = true;

  hardware.nvidia.modesetting.enable = true;
}
