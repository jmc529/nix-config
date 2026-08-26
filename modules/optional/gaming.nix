{ config, lib, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFireweall = true;
    dedicatedServer.openFirewall = false;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  hardware.graphics = {
    enable = true;
    enable32bit = true;
  };
}
