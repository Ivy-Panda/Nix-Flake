{ config, nixpkgs, home-manager, ...}: {

  programs.git = {
    enable = true;
    userName = "Ivy-Panda";
    userEmail = "128657643+Ivy-Panda@users.noreply.github.com";

    extraConfig = {
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/keys/github.pub";
      commit.gpgsign = "true";
      gpg.ssh.allowedSignersFile = "~/.ssh/keys/github.auth";
    };
  };
}

