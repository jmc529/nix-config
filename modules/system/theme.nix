{ inputs, pkgs, ... }:

{
  stylix = { 
    enable = true;
    image = "${inputs.self}/assets/ponyo-background.png";
    # 0x96f, danqing, decaf, material-darker, penumbra-dark
    base16Scheme = "${pkgs.base16-schemes}/share/themes/danqing.yaml";
    polarity = "dark";

    fonts = {
      emoji = {
        package = pkgs.openmoji-color;
        name = "OpenMoji";
      };
      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      sizes = {
        applications = 10;
        desktop = 10;
        popups = 10;
        terminal = 10;
      };
    };
  };
}
