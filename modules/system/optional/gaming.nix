{ config, lib, pkgs, ... }:
let
  cfg = config.modules.optional.gaming;
in
{
  options.modules.optional.gaming.enable = lib.mkEnableOption "Gaming support (Steam, GameMode, graphics acceleration)";

  config = lib.mkIf cfg.enable {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
      "proton-ge-bin"
    ];

    programs.steam = {
      enable = true;

      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = false;
      localNetworkGameTransfers.openFirewall = true;

      gamescopeSession.enable = true;

      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };

    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };

    programs.gamemode.enable = true;

    powerManagement.cpuFreqGovernor = "performance";

    environment.systemPackages = with pkgs; [
      # TODO: try itch/lutris/emulators more
      # Game launchers
      lutris
      itch

      # Emulators
      dolphin-emu
      pcsx2
      rpcs3
      melonds
      eden
      mgba
      retroarch

      # Software
      protonup-qt
      jdk21

      # Performance / diagnostics
      mangohud

      # Minecraft
      modrinth-app
      mcaselector
      prismlauncher
    ];
  };
}
