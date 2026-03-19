{ config, pkgs, home-manager, ... }: {

  home.username = "ivy";
  home.homeDirectory = "/home/ivy";
  home.stateVersion = "22.11";

  imports = [
    ./modules/home/git.nix
  ];

  xdg.configFile."sway/config".source = ./modules/swayconfig;

  #Force cursor theme to fix tiny cursor
  home.pointerCursor = {
    sway.enable = true;
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };
} 
