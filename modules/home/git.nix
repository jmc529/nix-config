{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "jmc529";
    userEmail = "jmc529@users.noreply.github.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    }
  }
}
