{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push = { autoSetupRemote = true; };
      user = {
        name = "jmc529";
        email = "jmc529@users.noreply.github.com";
      };
    };
  };
}
