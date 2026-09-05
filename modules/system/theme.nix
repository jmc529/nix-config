{ config, lib, pkgs, ... }:

{
  stylix.image = ./assets/ponyo-background.png;

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/pastelon-de-amarillos-dark.yaml";

  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.fira-code;
      name = "FiraCode Nerd Font Mono";
    };

    sansSerif = {
      package = pkgs.nerd-fonts.fira-code;
      name = "FiraCode Nerd Font";
    };


    emoji = {
      package = pkgs.noto-fonts-color-emoji;
      name = "Noto Color Emoji";
    };
  };
  
  stylix.fonts.serif = config.stylix.fonts.sansSerif;
}
