# nix

Personal NixOS config, built using plasma manager, sylix, flakes, and home manager.

## Install

On a machine with NixOS run:

```sh
git clone git@github.com:jmc529/nix-config.git ~/nix-config
cd ~/nix-config

# Generate machine hardware config
sudo nixos-generate-config --show-hardware-config > hosts/<name>/hardware-configuration.nix

# Generate kde config
nix run github:nix-community/plasma-manager > plasma-settings.nix

# Build and switch config
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

## Secrets (sops-nix)

Secrets (like the CircleCI token) are encrypted with [sops](https://github.com/getsops/sops)
and decrypted per-machine using that machine's SSH host key, converted to an
age key. Because of that, a brand-new machine can't decrypt anything until
it's been added as a recipient.

### Adding a new machine as a secrets recipient

This only needs to be done once per new machine, and needs to happen
**before** the first `nixos-rebuild switch` that pulls in `sops.nix`,
otherwise the activation will fail trying to decrypt secrets it isn't a
recipient for yet.

1. Install NixOS and boot the new machine at least once with
   `services.openssh.enable = true` so its host key exists at
   `/etc/ssh/ssh_host_ed25519_key`.

2. Get that host's SSH key as an age public key:

```sh
   nix run nixpkgs#ssh-to-age -- -i /etc/ssh/ssh_host_ed25519_key.pub
```

3. Add the resulting `age1...` key to `.sops.yaml` at the repo root, under
   a new anchor (e.g. `&newhostname`), and add it to the `age:` list for
   the relevant `path_regex`.

4. From a machine that can **already** decrypt the secrets (i.e. one
   already listed as a recipient), re-key the existing secrets files so
   the new machine can decrypt them too:

```sh
   nix run nixpkgs#sops -- updatekeys secrets/sops.yaml
```

   (`updatekeys` re-wraps the existing encrypted data key for every
   recipient currently listed in `.sops.yaml` — just adding the new
   recipient to `.sops.yaml` alone does **not** retroactively grant it
   access.)

5. Commit both the updated `.sops.yaml` and the re-keyed `secrets/sops.yaml`,
   pull them onto the new machine, then proceed with the normal install
   steps below.

### Adding a new secret

```sh
nix run nixpkgs#sops -- secrets/sops.yaml
```

opens the file decrypted in `$EDITOR`; add the key, save, and it's
re-encrypted automatically to all current recipients. Then wire it up in
`sops.nix` (`sops.secrets."name"`) or as a `sops.templates` entry if it
needs to be merged into a generated config file.