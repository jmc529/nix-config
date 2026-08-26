{ config, lib, pkgs, ... }:

# TODO configure by hand then run plasma manager's rc2nix to generate settings.
{
  programs.plasma = {
    enable = true;
  }
}
