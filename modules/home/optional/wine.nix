{ config, lib, pkgs, ... }:
let
  cfg = config.modules.optional.wine;
in
{
  options.modules.optional.wine.enable = lib.mkEnableOption "Wine for running Windows apps";

  # TODO: move wine out of optional?
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      wineWow64Packages.stable
      winetricks
      bottles
    ];
  };
}