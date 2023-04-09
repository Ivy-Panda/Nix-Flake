{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    _1password
    browsh
    firefox
    fortune
    git
    htop
    lynx
    openssl
    pridefetch
    screenfetch
    weechat
    wget
    mosh
  ];
}
