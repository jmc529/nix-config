{ pkgs, ... }:

{
  # sudo smartctl -a /dev/sda        # full SMART report
  # sudo smartctl -H /dev/sda        # just pass/fail health summary
  # sudo smartctl -t short /dev/sda  # run a short self-test

  # sudo nvme list                    # list all NVMe devices
  # sudo nvme smart-log /dev/nvme0    # health/wear info: temp, spare %, media errors
  environment.systemPackages = with pkgs; [
    smartmontools
    nvme-cli
  ];

  services.smartd = {
    enable = true;
    notifications.wall.enable = true;
  };
}
