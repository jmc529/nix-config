{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "jmc529";
    userEmail = "jmc529@users.noreply.github.com";

    settings = {
      push = { autoSetupRemote = true; };
    };

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
