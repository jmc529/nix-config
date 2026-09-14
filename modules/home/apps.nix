{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # messaging
    element-desktop
    discord
    signal-desktop

    # creative
    libreoffice
    obs-studio
    obsidian

    # dev tools
    bruno
    devtoolbox
    gh
    httpie
    # nix doc format https://github.com/NixOS/nixfmt
    nixfmt
    tealdeer

    # music
    sone

    # Management
    bitwarden-desktop
    # update nix pkgs https://github.com/Mic92/nix-update
    nix-update
  ];
}
