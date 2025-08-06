{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    _1password-gui
    signal-desktop
    tdesktop
    racket
    krita
  ];
}
