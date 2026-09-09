# modules/optional/gaming.nix
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

    environment.systemPackages = with pkgs; [
      itch                # itch.io client

      dolphin-emu         # GameCube / Wii
      duckstation          # PS1 (more accurate than PCSX)
      pcsx2                # PS2
      rpcs3                # PS3
      melonDS              # Nintendo DS
      eden                  # Switch (actively-maintained Yuzu/Suyu successor)
      mgba                 # GBA / GB / GBC
      retroarch            # multi-system frontend + cores
    ];
  };
}
