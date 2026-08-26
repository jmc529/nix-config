{ config, lib, pkgs, ... }:

{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.desktopManager.plasma6.enable = true;

  # touch/rotation
  # TODO check if needed or can be in hosts
  services.libinput.enable = true;
}
