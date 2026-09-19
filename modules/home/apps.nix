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
    # Need to use 6.3 LTS
    (unityhub.override {
      extraLibs = pkgs: with pkgs; [
        ncurses
        libxml2
        openssl
        icu
        zlib
      ];
    })
    # cat replacement
    bat
    bruno
    cmake
    devtoolbox
    gh
    httpie
    # nix doc format https://github.com/NixOS/nixfmt
    nixfmt
    tealdeer
    # Show file structure
    tree
    winboat

    # media
    sone
    mpv
    ffmpeg
    openshot-qt

    # Management
    bitwarden-desktop
    # update nix pkgs https://github.com/Mic92/nix-update
    nix-update
    (pkgs.callPackage "${inputs.self}/modules/packages/plasma6-eventcalendar.nix" { })

    # Wine
    wineWow64Packages.stable
    winetricks
    bottles
  ];
}
