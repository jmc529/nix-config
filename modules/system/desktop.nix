{ config, lib, pkgs, ... }:

{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    kate
    konsole
    discover
    plasma-workspace-wallpapers
    khelpcenter
    qrca
    elisa
  ];

  # firmware updates since I am removing discover; CLI fwupdmgr
  services.fwupd.enable = true;
}
