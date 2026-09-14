{ inputs, ... }:

let
  drives = {
    "/mnt/hdd-1tb" = "5E42CC0142CBDC41";
    "/mnt/ssd-1tb" = "FC96EEF396EEACF8";
    "/mnt/ssd-256gb" = "FE3E12853E12375D";
  };
in
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system
    ../../modules/system/optional
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  networking.hostName = "aorus";

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  fileSystems = builtins.mapAttrs (_: uuid: {
    device = "/dev/disk/by-uuid/${uuid}";
    fsType = "ntfs";
    options = [
      "defaults"
      "nofail"
      "uid=1000"
      "gid=1000"
      "umask=022"
    ];
  }) drives;

  system.stateVersion = "26.05";

  modules = {
    optional = {
      gaming.enable = true;
      ollama.enable = true;
      winapps.enable = false;
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    users.joe = {
      imports = [
        ../../modules/home
        ../../modules/home/optional
      ];

      modules = {
        optional = {
          wine.enable = false;
          opencode.enable = true;
        };
      };
    };
  };
}
