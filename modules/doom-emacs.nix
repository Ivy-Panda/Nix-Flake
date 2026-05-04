{ pkgs, ... }: {

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
      sha256 = "VISrZxLM/Eldfa6DogJYbatOTkyFHsbYU613neAyldg=";
    }))
  ];

  environment.systemPackages = [
    pkgs.emacs-git
    pkgs.fd
    pkgs.ripgrep
    pkgs.nerd-fonts.symbols-only
    pkgs.symbola
  ];
}
