{ config, lib, ... }:
let
  cfg = config.modules.optional.audio-prod;
in
{
  options.modules.optional.audio-prod.enable = lib.mkEnableOption "audio production support";

  config = lib.mkIf cfg.enable {
    musnix.enable = true;
    musnix.rtcqs.enable = true;   # TODO: adds `rtcqs`, a CLI tool that audits your system
                                  # review what it tells you what's still not audio-friendly

    users.users."joe".extraGroups = [ "audio" ];

    services.pipewire.jack.enable = true;
  };
}