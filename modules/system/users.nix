{ config, lib, pkgs, ... }:

{
  programs.zsh.enable = true;
  users.users.joe = {
    isNormalUser = true;
    description = "Joe";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.zsh;
  };
}
