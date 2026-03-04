{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    #FIXME
    _1password-gui
    signal-desktop
    telegram-desktop
    racket
    krita
    wlsunset
  ];
}
