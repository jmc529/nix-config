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

    # nix mcp (AI model context protocal) gives info on nix https://github.com/utensils/mcp-nixos
    mcp-nixos
    
    # nix doc format https://github.com/NixOS/nixfmt
    nixfmt

    # update nix pkgs https://github.com/Mic92/nix-update
    nix-update

    # https://nixsoftware.org/en/packages/devtoolbox?channel=2605
    devtoolbox
  ];
}
