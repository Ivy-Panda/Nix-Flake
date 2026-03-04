{ config, nixpkgs, home-manager, ...}: {

  programs.git = {

    enable = true;

    settings = {

      user = {
        Name = "Ivy-Panda";
        Email = "128657643+Ivy-Panda@users.noreply.github.com";
        signingkey = "~/.ssh/keys/github.pub";
      };

      commit.gpgsign = "true";

      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.ssh/keys/github.auth";
      };
    };
  };
}
