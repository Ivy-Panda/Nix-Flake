{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    signal-desktop
    telegram-desktop
    racket
    krita
    wlsunset
  ];
}
