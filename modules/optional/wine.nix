{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    wineWowPackages.stable
    winetricks
    bottles
  ];
}
