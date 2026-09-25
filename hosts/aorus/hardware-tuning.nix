{ pkgs, ... }:

{
  # sudo smartctl -a /dev/sda        # full SMART report
  # sudo smartctl -H /dev/sda        # just pass/fail health summary
  # sudo smartctl -t short /dev/sda  # run a short self-test

  # sudo nvme list                    # list all NVMe devices
  # sudo nvme smart-log /dev/nvme0    # health/wear info: temp, spare %, media errors
  environment = {
    systemPackages = with pkgs; [
      smartmontools
      nvme-cli
      lm_sensors
      radeontop
      powertop
      vulkan-tools
    ];

    variables = {
      AMD_VULKAN_ICD = "RADV";
      RADV_PERFTEST = "nggc";
      LIBVA_DRIVER_NAME = "radeonsi";
      MESA_LOADER_DRIVER_OVERRIDE = "radeonsi";
    };
  };

  hardware = {
    amdgpu.overdrive.enable = false;

    graphics.extraPackages = with pkgs; [
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
    ];
  };

  services = {
    hardware.openrgb.enable = true;
    smartd = {
      enable = true;
      notifications.wall.enable = true;
    };

    # Power management for SATA, NVME, and GPU
    udev.extraRules = ''
      ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{power/control}="auto"
      ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{power/control}="auto"
      ACTION=="add|change", KERNEL=="nvme[0-9]n[0-9]", ATTR{queue/scheduler}="none"
      ACTION=="change", SUBSYSTEM=="drm", ATTR{power_control}="auto"
    '';
  };
}