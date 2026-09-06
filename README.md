# nix

Personal NixOS config, built using plasma manager, sylix, flakes, and home manager.

## Install

On a machine with NixOS run:

```sh
git clone git@github.com:jmc529/nix-config.git ~/nix-config
cd ~/nix-config

# Generate machine hardware config
sudo nixos-generate-config --show-hardware-config > hosts/<name>/hardware-configuration.nix

sudo nixos-rebuild switch --flake ./#<name>
```

### Develop

```sh
# To recreate the pre-commit, run:
nix develop

# Manual commands from the pre-commit
nix run nixpkgs#statix -- check .
nix run nixpkgs#deadnix -- .

# To lint
nix flake check
```
