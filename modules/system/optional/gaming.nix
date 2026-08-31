{ config, lib, pkgs, ... }:
let
  cfg = config.modules.optional.gaming;
in
{
  options.modules.optional.gaming.enable = lib.mkEnableOption "gaming support (Steam, GameMode, graphics acceleration)";

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = false;
      gamescopeSession.enable = true;
    };

    programs.gamemode.enable = true;

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}