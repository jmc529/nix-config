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

    # music
    tidal-hifi

    # Management
    bitwarden-desktop
    sioyek
  ];
}
