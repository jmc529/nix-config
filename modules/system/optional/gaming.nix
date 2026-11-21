{ config, inputs, lib, pkgs, ... }:


let
  cfg = config.modules.optional.gaming;

  amethyst = inputs.amethyst.packages.${pkgs.stdenv.hostPlatform.system}.default;
  hearthstone = inputs.hearthstone.packages.${pkgs.stdenv.hostPlatform.system}.default ;

  itchWithWine = pkgs.symlinkJoin {
    name = "itch-with-wine";
    paths = [ pkgs.itch ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/itch \
        --prefix PATH : ${lib.makeBinPath [ pkgs.wineWow64Packages.stable ]}
    '';
    meta.mainProgram = "itch";
  };
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

    programs = {
      firejail.enable = true;
      gamemode.enable = true;

      gamescope = {
        enable = true;
        capSysNice = true;
      };

      steam = {
        enable = true;

        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = false;
        localNetworkGameTransfers.openFirewall = true;

        gamescopeSession.enable = true;

        extraCompatPackages = [ pkgs.proton-ge-bin ];
      };
    };

    powerManagement.cpuFreqGovernor = "performance";

    environment.systemPackages = with pkgs; [
      # Game launchers
      itchWithWine

      # Emulators
      dolphin-emu
      pcsx2

      # Software/Modloaders
      amethyst
      jdk21
      r2modman

      # Games
      hearthstone

      # Performance / diagnostics
      mangohud

      # Minecraft
      modrinth-app
      mcaselector
      prismlauncher
    ];
  };
}
