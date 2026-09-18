{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # messaging
    element-desktop
    discord
    signal-desktop
    thunderbird
    quassel

    # creative
    libreoffice
    obs-studio
    obsidian

    blender
    krita
    gimp-with-plugins
    tiled
    blockbench
    hieroglyphic

    audacity
    mixxx
    bitwig-studio
    # TODO: try to add: https://github.com/Torbuntu/fl-studio-linux-setup


    # dev tools
    # TODO: unity is breaking need to review
    unityhub
    bruno
    devtoolbox
    gh
    httpie
    # nix doc format https://github.com/NixOS/nixfmt
    nixfmt
    tealdeer
    winboat

    # media
    sone
    mpv

    # Management
    bitwarden-desktop
    # update nix pkgs https://github.com/Mic92/nix-update
    nix-update
  ];
}
