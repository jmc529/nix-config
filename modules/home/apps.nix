{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    # messaging
    discord
    signal-desktop

    # creative
    obs-studio
    obsidian

    # dev tools
    bruno
    httpie

    # file mngmt
    thunar

    # music
    tidal-hifi
  ]
}
