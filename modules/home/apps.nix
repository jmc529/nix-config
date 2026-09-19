{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    # messaging
    element-desktop
    discord
    signal-desktop
    quassel
    mailspring

    # creative
    libreoffice
    obs-studio
    obsidian
    p3x-onenote

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
    tree                # Show file structure
    bat                 # cat replacement
    cmake               # Cross-platform open-source build system generator
    winboat

    # media
    sone
    mpv

    # Management
    bitwarden-desktop
    # update nix pkgs https://github.com/Mic92/nix-update
    nix-update
    (pkgs.callPackage "${inputs.self}/modules/packages/plasma6-eventcalendar.nix" { })
  ];
}
