{ pkgs, ... }:

{
  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    desktopManager.plasma6.enable = true;
    fwupd.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    kate
    konsole
    discover
    plasma-workspace-wallpapers
    khelpcenter
    qrca
    kde-gtk-config
  ];
}
