{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd

    ../../modules/system
    ../../modules/optional/gaming.nix
  ];

  networking.hostName = "flex5";

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "26.05";

  home-manager.user.joe = {
    imports = [
      ../../modules/home
      # Optional windows support - this host will use wine + bottles not winapps
      ../../modules/optional/wine.nix
    ]
  }
}
