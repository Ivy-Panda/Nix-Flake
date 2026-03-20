{ config, pkgs, ... }: {

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  boot = {
  # Use the systemd-boot EFI boot loader.
  loader.systemd-boot.enable = false;
  loader.efi.canTouchEfiVariables = true;

  # Use Lanzaboote for Secure Boot
  lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
    settings.reboot-for-bitlocker = true;
  };

  # FDE initialization 
  initrd.luks.devices.cryptroot={device="/dev/disk/by-partlabel/nix";};

  # Don't import zfs pools that were not properly exported
  zfs = {
    forceImportAll = false;
    forceImportRoot = false;
  };
};

  # Set your time zone.
  time.timeZone = "US/Eastern";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [ "tok/UTF-8" ];
    extraLocaleSettings = { LC_TIME = "C.UTF-8"; }; # Sets the time format to 24h somehow
  };

  # Use xkbOptions in console
  console.useXkbConfig = true;

  # Use Lix instead of Nix
  nix.package = pkgs.lixPackageSets.stable.lix;

  # Allow unfree packages systemwide
  nixpkgs.config.allowUnfree = true;

  # Define users
  security.sudo.extraConfig = "Defaults lecture=never";
  security.polkit.enable = true;

  users = {
    mutableUsers = false;

    users.ivy = {
      isNormalUser = true;
      extraGroups = [ "wheel" "wireshark" ];
      hashedPasswordFile = "/persist/shadow/ivy";
    };
  };

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default

  # Enable dev documentation
  documentation.dev.enable = true;

  # Enable services
  services = {
  # Enable Tailscale
  tailscale.enable = true;

  # Enable firmware update daemon
  fwupd.enable = true;

  # Configure keymap in X11
  xserver.xkb.layout = "us";
  xserver.xkb.options = "ctrl:swapcaps"; # swaps capslock and ctrl

  # Enable CUPS to print documents.
  # printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # xserver.libinput.enable = true;
};

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # Strict reverse path filtering breaks Tailscale exit node use
  networking.firewall = {
    allowedUDPPorts = [ 60001 ];
    checkReversePath = "loose";

    # Make trilium-server exception
    interfaces.tailscale0.allowedTCPPorts = [ 9876 ];
  };

  # Change bash / anything using readline to use vi mode and show colored mode indicators
  environment.etc."inputrc".text = ''
    set editing-mode vi
    set show-mode-in-prompt on
    set vi-ins-mode-string "\1\e[1;32m\2[i]\1\e[0m\2"
    set vi-cmd-mode-string "\1\e[1;32m\2[\1\e[1;31m\2c\1\e[1;32m\2]\e[0m\2"
  '';

  # TODO: This is a temporary workaround for Network Manager errors on rebuild
  # github:NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.services.systemd-networkd-wait-online.enable = false;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable 1password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["ivy"];
  };

  # Enable Wireshark
  programs.wireshark.enable = true;
  environment.systemPackages = [ pkgs.wireshark-qt ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
