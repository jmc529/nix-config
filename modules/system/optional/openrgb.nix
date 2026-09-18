{ config, lib, ... }:

let
  cfg = config.modules.optional.openrgb;
in
{
  options.modules.optional.openrgb.enable = lib.mkEnableOption "openrgb support";

  config = lib.mkIf cfg.enable {
    services.hardware.openrgb.enable = true;
  };
}
