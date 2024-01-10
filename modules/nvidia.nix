{ config, pkgs, ...}: {

  services.xserver.videoDrivers = ["nvidia"];
  hardware.opengl.enable = true;

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;

  hardware.nvidia.modesetting.enable = true;
}
