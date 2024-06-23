{ config, pkgs, ... }: {

  services.trilium-server = {
    enable = true;

    host = "100.77.83.66";
    port = 9876;

    dataDir = "/persist/var/lib/trilium";
  };

  # Fix for Tailscale saying it has bound ip before it has
  systemd.services.trilium-server.serviceConfig = {
    Restart = "on-failure"; RestartSec = 5;
  };
}
