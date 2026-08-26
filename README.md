# nix

Personal NixOS config, built using plasma manager, sylix, flakes, and home manager.

## Install

Ona machine with NixOS run:

```sh
git clone <repo-url> ~/nix
cd ~/nix

# Generate machine hardware config
sudo nixos-generate-config --show-hardware-config > hosts/<name>/hardware-configuration.nix

sudo nixos-rebuild switch --flake .#<name>
```