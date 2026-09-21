{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    # messaging
    element-desktop
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
    fastfetch
    gh
    httpie
    # nix doc format https://github.com/NixOS/nixfmt
    nixfmt
    tealdeer
    # Show file structure
    tree

    gcc
    lua
    jdk
    nodejs
    prettier
    python3
    typescript

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
    kdePackages.merkuro

    # Windows
    # winboat - don't really need - Can remove bloatware in winboat with `irm christitus.com/win | iex`
    wineWow64Packages.stable
    bottles
  ];
}
