{ config, lib, pkgs, ... }:

{
  users.users.joe = {
    isNormalUser = true;
    description = "Joe";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
}
