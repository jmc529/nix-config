{ config, lib, pkgs, ... }:

{
  networking.networkmanager = {
    enable = true;
    plugins = [ pkgs.networkmanager-openvpn ];
  };

  hardware.bluetooth = {
  enable = true;
  powerOnBoot = true;
  settings = {
    General = {
      # Shows battery charge of connected devices
      Experimental = true;
      ControllerMode = "bredr";
    };
  };

  services.printing.enable = true;
}
