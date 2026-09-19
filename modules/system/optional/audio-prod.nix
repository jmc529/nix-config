{ config, lib, ... }:
let
  cfg = config.modules.optional.audio-prod;
in
{
  options.modules.optional.audio-prod.enable = lib.mkEnableOption "audio production support";

  config = lib.mkIf cfg.enable {
    musnix.enable = true;
    musnix.rtcqs.enable = true;
    powerManagement.cpuFreqGovernor = "performance";
    users.users."joe".extraGroups = [ "audio" ];
    services.pipewire.jack.enable = true;
  };
}