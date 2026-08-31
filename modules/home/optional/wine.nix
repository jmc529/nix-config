{ config, lib, pkgs, ... }:
let
  cfg = config.modules.optional.wine;
in
{
  options.modules.optional.wine.enable = lib.mkEnableOption "Wine for running Windows apps";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      wineWowPackages.stable
      winetricks
      bottles
    ];
  };
}