{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wget
    fortune
    git
    lynx
    weechat
    browsh
    firefox
    screenfetch
    pridefetch
    htop
    openssl
  ];
}
