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

- [Adding in FL Studio via bottles](https://github.com/Torbuntu/fl-studio-linux-setup) - can use the same bottle for [Aurora](https://aurorabuilder.com/)

### Develop

```sh
# To recreate the pre-commit, run:
nix develop

# Manual commands from the pre-commit
nix run nixpkgs#statix -- check .
nix run nixpkgs#deadnix -- .

# To lint
nix flake check


# To delete old gens
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
sudo nix-collect-garbage -d && sudo nix-store --gc
```

## Secrets (agenix)

Secrets (like the CircleCI token) are encrypted with [agenix](https://github.com/ryantm/agenix)
and decrypted during activation using that machine's SSH host key. Because
of that, a brand-new machine can't decrypt anything until it's been added as a
recipient.

The recipients live in `secrets/agenix-rules.nix`; the encrypted files sit
next to it as `secrets/<name>.age`. Each one is wired up in
`modules/system/agenix.nix` and decrypted to `/run/agenix/<name>`.

### Adding a new machine as a secrets recipient

This only needs to be done once per new machine, and needs to happen
**before** the first `nixos-rebuild switch` that pulls in `agenix.nix`,
otherwise the activation will fail trying to decrypt secrets it isn't a
recipient for yet.

1. Install NixOS and boot the new machine at least once with
   `services.openssh.enable = true` so its host key exists at
   `/etc/ssh/ssh_host_ed25519_key`.

2. Add that host key to `secrets/agenix-rules.nix`:

```sh
   cat /etc/ssh/ssh_host_ed25519_key.pub
```

3. From a machine that can **already** decrypt the secrets (i.e. one
   already listed as a recipient), re-encrypt every secret for the new
   recipients:

```sh
   nix run github:ryantm/agenix -- -r
```

   (`-r`/`--rekey` re-encrypts the secrets listed in `agenix-rules.nix`.
   Just adding a recipient to `agenix-rules.nix` alone does **not**
   retroactively grant it access.)

4. Commit both the updated `secrets/agenix-rules.nix` and the re-encrypted
   `secrets/*.age` files, pull them onto the new machine, then proceed with
   the normal install steps above.

### Adding a new secret

```sh
nix run github:ryantm/agenix -- -e secrets/<name>.age
```

opens the file decrypted in `$EDITOR`; add the value, save, and it's
re-encrypted automatically for every recipient in `agenix-rules.nix`. Then
declare it in `modules/system/agenix.nix` as an `age.secrets` entry and
reference `config.age.secrets.<name>.path` from whatever consumes it.

### Secrets that need to be merged into a generated file

agenix only decrypts whole files, so it has no equivalent of sops-nix's
`templates`. For the CircleCI token, `modules/home/ide.nix` handles it
instead: the VSCodium settings are declared normally (and Home Manager
merges them into `settings.json` on every activation because
`mutableUserSettings` is set), and the
`vscodium-settings-token` user unit merges the decrypted token in with
`jq` at login. Because the token is not one of the settings Home Manager
knows about, it survives every subsequent activation.
