{ config, nixpkgs, home-manager, ...}: {

  programs.git = {
    enable = true;
    userName = "Ivy-Panda";
    userEmail = "128657643+Ivy-Panda@users.noreply.github.com";

    extraConfig = {
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/id_ed25519.pub";
      commit.gpgsign = "true";
    };
  };
}

