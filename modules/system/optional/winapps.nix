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
      pkgs.freerdp        # RDP client winapps shells out to
      pkgs.dialog         # used by the winapps-setup TUI installer
    ];

    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = false; # optional, only if you want USB passthrough into the VM
    programs.virt-manager.enable = true; # GUI for creating/managing the Windows VM

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