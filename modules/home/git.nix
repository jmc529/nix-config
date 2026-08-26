{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "jmc529";
    userEmail = "jmconwell54@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    }
  }
}
