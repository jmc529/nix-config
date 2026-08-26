{ config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes"];
  nixpkgs.convifg.allowUnfree = true;

  # Trim old gens
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  boot.loader.system-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
