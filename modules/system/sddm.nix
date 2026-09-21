{ inputs, pkgs, ... }:

let
  wallpaper = "${inputs.self}/assets/ponyo-background.png";
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    enableHidpi = true;
    theme = "breeze";
  };

  environment.systemPackages = [
    (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
      [General]
      type=image
      background=${wallpaper}
    '')
  ];
}