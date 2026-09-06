{ pkgs, ... }:

{
  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    desktopManager.plasma6.enable = true;
    # firmware updates since I am removing discover; CLI fwupdmgr
    fwupd.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    kate
    konsole
    discover
    plasma-workspace-wallpapers
    khelpcenter
    qrca
    elisa
    kde-gtk-config
  ];  
}
