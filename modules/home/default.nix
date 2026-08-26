{ config, lib, pkgs, ... }:

{
  imports = [
    ./apps.nix
    ./firefox.nix
    ./git.nix
    ./plasma.nix
    ./shell.nix
    ./terminal.nix
    ./vscode.nix
  ];

  home.username = "joe";
  home.homeDirectory = "/home/joe";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
