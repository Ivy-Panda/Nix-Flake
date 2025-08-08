{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    _1password-cli
    browsh
    firefox
    # I like to laugh at the cringe
    ( fortune.override { withOffensive = true; } )
    git
    htop
    lynx
    openssl
    freshfetch
    neofetch
    wget
    mosh
    sbctl
  ];
}
