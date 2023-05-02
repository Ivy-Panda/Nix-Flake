{ config, pkgs, ... }: {

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default

  # Define users
  security.sudo.extraConfig = "Defaults lecture=never";

  users = {
  mutableUsers = false;
  
  users.ivy = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      passwordFile = "/persist/shadow/ivy";
    };
  };

  # Set your time zone.
  time.timeZone = "US/Eastern";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  i18n.extraLocaleSettings = { LC_TIME = "C"; }; # Sets the time format to 24h somehow

  # Use xkbOptions in console
  console.useXkbConfig = true;

  # Configure keymap in X11
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "ctrl:swapcaps"; # swaps capslock and ctrl

  # Change bash / anything using readline to use vi mode and show colored mode indicators
  environment.etc."inputrc".text = ''
    set editing-mode vi
    set show-mode-in-prompt on
    set vi-ins-mode-string "\1\e[1;32m\2[i]\1\e[0m\2"
    set vi-cmd-mode-string "\1\e[1;32m\2[\1\e[1;31m\2c\1\e[1;32m\2]\e[0m\2"
  '';

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # Strict reverse path filtering breaks Tailscale exit node use
  networking.firewall = {
    allowedUDPPorts = [ 60001 ];
    checkReversePath = "loose";
  }

  services.tailscale.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  security.polkit.enable = true;

  # Stuff to make fde work
  boot.initrd.luks.devices.cryptroot={device="/dev/disk/by-partlabel/nix";};

  # Don't import zfs pools that were not properly exported
  boot.zfs = {
    forceImportAll = false;
    forceImportRoot = false;
  };

  #  services.xserver.dpi=192;

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];
}
