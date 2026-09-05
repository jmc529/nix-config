{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.modules.optional.winapps;
  system = pkgs.system;
in
{
  options.modules.optional.winapps.enable = lib.mkEnableOption "WinApps integration for running Windows apps via RDP/VM";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      inputs.winapps.packages.${system}.winapps
      inputs.winapps.packages.${system}.winapps-launcher
    ];
  };
}