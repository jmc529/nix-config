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
    lsd
    # nix doc format https://github.com/NixOS/nixfmt
    nixfmt
    # https://nix-community.github.io/home-manager/options/home-manager/programs/oh-my-posh.html
    oh-my-posh
    tealdeer

    # music
    tidal-hifi

    # Management
    bitwarden-desktop
    # update nix pkgs https://github.com/Mic92/nix-update
    nix-update
  ];
}
