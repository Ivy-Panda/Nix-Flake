{ config, nixpkgs, home-manager, ...}: {

  # TODO move the ssh config to a different module
  programs.ssh = {
    enable = true;

    matchBlocks.github = {
      host = "github.com github";
      hostname = "github.com";
      user = "git";
      identityFile = "~/.ssh/keys/github";
    };
  };

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

