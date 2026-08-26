{ config, lib, pkgs, ... }:

{
  # TODO swap background
  stylix.image = pkgs.nixos-artwork.wallpapers.simple-dark-gray.gnomeFilePath;

  # verify this is what I want
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/city-lights.yaml";

  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.fira-code;
      name = "FiraCode Nerd Font";
    };

    sansSerif = {
      package = pkgs.nerd-fonts.fira-code;
      name = "FiraCode Nerd Font";
    };

    serif = {
      package = pkgs.nerd-fonts.fira-code;
      name = "FiraCode Nerd Font";
    };
  };

  # plasma is themed separately - modules/home/plasma.nix
  stylix.targets.plasma.enable = true;
}
