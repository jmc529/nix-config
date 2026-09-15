# WinApps Setup & Testing

Checklist for getting WinApps working on a new machine. The Nix module
(`modules/optional/winapps.nix`) only installs the tooling and grants
permissions — it can't create the Windows VM or configure RDP inside it.
Everything below that isn't a `nix` command has to be done by hand, once,
per machine.

## 1. Enable the module and rebuild

```nix
modules.optional.winapps.enable = true;
```

```sh
sudo nixos-rebuild switch --flake ./#<name>
```

## 2. Reboot or re-login

Required for the `libvirtd` and `kvm` group membership to take effect in
your session. Skipping this is the #1 cause of "permission denied" errors
talking to libvirt.

## 3. Verify libvirtd and the default network

```sh
systemctl status libvirtd

virsh net-list --all
# If "default" shows inactive:
sudo virsh net-autostart default
sudo virsh net-start default
```

## 4. Create the Windows VM

Use `virt-manager` (already enabled by the module) to create a VM:

- **Name it exactly `RDPWindows`** — this must match `VM_NAME` in
  `winapps.conf`.
- Attach the `default` NAT network so it's reachable from the host.
- Windows 10 Pro/Enterprise or Windows 11. **Home edition can't accept
  inbound RDP** without registry hacks — don't use it.
- If installing Windows 11: needs Secure Boot + TPM 2.0. Make sure
  `virtualisation.libvirtd.qemu.swtpm.enable` and `...ovmf.enable` are set
  in the module (see config reference below), and use UEFI firmware for
  the VM.
- If using VirtIO disk/network devices, attach the
  [VirtIO driver ISO](https://github.com/virtio-win/virtio-win-pkg-scripts)
  during install or Windows won't see the disk.

## 5. Configure the Windows guest

Inside the running Windows VM:

- Create a local account matching `RDP_USER` in your config
  (e.g. `Joe-Winapps`) with a real password.
- **Settings → System → Remote Desktop → On.**
- Allow Remote Desktop through Windows Firewall (usually prompted
  automatically, or check under Windows Defender Firewall settings).

## 6. Find the VM's IP

```sh
virsh domifaddr RDPWindows
```

## 7. Test raw RDP connectivity first

Do this **before** touching WinApps — it isolates "is my VM/RDP set up
right" from "is WinApps' config right".

```sh
xfreerdp /v:<VM_IP> /u:Joe-Winapps /p:<password> /dynamic-resolution +clipboard
```

If this doesn't connect cleanly, fix that before moving on — WinApps will
fail the same way for the same reason.

## 8. Run the WinApps setup wizard

```sh
winapps-setup
```

This is the `dialog`-based TUI that queries the VM over RDP for installed
apps and creates launcher shortcuts on the host.

## 9. Test a launched app

Launch one of the shortcuts created in step 8, or run `winapps-launcher`
directly. If it fails, enable debug logging:

```
# in ~/.config/winapps/winapps.conf
DEBUG=true
```

then check `~/.local/share/winapps/winapps.log` for what FreeRDP is
actually doing.

---

## Troubleshooting quick reference

| Symptom | Likely cause |
|---|---|
| `virsh` permission denied | Didn't reboot/re-login after group change |
| VM has no network | Default libvirt network not started |
| RDP connection refused | RDP not enabled in guest, or Home edition | 
| `xfreerdp` works, WinApps doesn't | Check `VM_NAME`/`RDP_USER` match exactly; enable `DEBUG=true` |
| Windows 11 install hangs/fails at TPM check | `swtpm`/`ovmf` not enabled, or VM not using UEFI firmware |

---

## Config reference

```nix
{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.modules.optional.winapps;
  inherit (pkgs) system;
in
{
  options.modules.optional.winapps.enable =
    lib.mkEnableOption "WinApps integration for running Windows apps via RDP/VM";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      inputs.winapps.packages.${system}.winapps
      inputs.winapps.packages.${system}.winapps-launcher
      pkgs.freerdp
      pkgs.dialog
      pkgs.iproute2
      pkgs.libnotify
      pkgs.netcat
    ];

    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        # Only needed for Windows 11 guests (TPM 2.0 + Secure Boot)
        swtpm.enable = true;
        ovmf.enable = true;
      };
    };
    virtualisation.spiceUSBRedirection.enable = false;
    programs.virt-manager.enable = true;

    users.users."joe".extraGroups = [ "libvirtd" "kvm" ];

    home-manager.users."joe" = {
      home.file.".config/winapps/winapps.conf".text = ''
        RDP_USER="Joe-Winapps"
        RDP_PASS="-"
        VM_NAME="RDPWindows"
        RDP_SCALE="100"
      '';
    };
  };
}
```

`RDP_PASS="-"` prompts for the password interactively on each launch
instead of storing it in plaintext. If you'd rather not be prompted, wire
the real password through sops-nix (same pattern as the CircleCI token)
instead of hardcoding it here.