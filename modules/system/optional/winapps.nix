{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.modules.optional.winapps;
  inherit (pkgs) system;
in
{
  options.modules.optional.winapps.enable = lib.mkEnableOption "WinApps integration for running Windows apps via RDP/VM";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      inputs.winapps.packages.${system}.winapps
      inputs.winapps.packages.${system}.winapps-launcher
      pkgs.freerdp
      pkgs.dialog
      pkgs.iproute2   # winapps' scripts use `ip` to detect VM IPs
      pkgs.libnotify  # desktop notifications on app launch/failure
      pkgs.netcat     # port-probing to check if RDP is up before connecting
    ];

    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        # Only needed if the guest is Windows 11 (TPM 2.0 + Secure Boot requirement)
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