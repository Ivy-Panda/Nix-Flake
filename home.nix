{ config, pkgs, home-manager, ... }: {

  home.username = "ivy";
  home.homeDirectory = "/home/ivy";
  home.stateVersion = "22.11";

  imports = [
    ./modules/home/git.nix
  ];

  xdg.configFile."sway/config".source = ./modules/swayconfig;
} 
