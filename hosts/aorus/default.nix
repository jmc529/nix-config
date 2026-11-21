{ inputs, ... }:

let
  ext4_drives = {
    "/mnt/ssd-256gb" = "39b9482e-365a-4081-92f7-13ee34f5a24d";
    "/mnt/ssd-500gb" = "5b2b4bd5-fd4b-4254-84b8-f003013e7aeb";
    "/mnt/ssd-1tb" = "5311eda3-c1cc-49ad-938b-f596340a5972";
    "/mnt/hdd-1tb" = "010e3a06-7cfd-47ab-a713-5c0a736a45e5";
  };

  mkExt4 = _: uuid: {
    device = "/dev/disk/by-uuid/${uuid}";
    fsType = "ext4";
    options = [
      "defaults"
      "nofail"
    ];
  };
in
{
  imports = [
    ./hardware-configuration.nix
    ./hardware-tuning.nix
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

  fileSystems = (builtins.mapAttrs mkExt4 ext4_drives);

  system.stateVersion = "26.05";

  modules = {
    optional = {
      audio-prod.enable = true;
      gaming.enable = true;
      ollama.enable = true;
    };
  };

  home-manager = {
    backupFileExtension = "backup";

    users.joe = { config, ... }: {
      imports = [
        ../../modules/home
        ../../modules/home/optional
      ];

      xdg.userDirs = {
        enable = true;
        documents = "/mnt/ssd-256gb/Documents";
        download = "/mnt/ssd-256gb/Downloads";
        music = "/mnt/ssd-256gb/Music";
        pictures = "/mnt/ssd-256gb/Pictures";
        videos = "/mnt/ssd-256gb/Videos";
      };

      home.file = {
        "Documents".source = config.lib.file.mkOutOfStoreSymlink "/mnt/ssd-256gb/Documents";
        "Music".source = config.lib.file.mkOutOfStoreSymlink "/mnt/ssd-256gb/Music";
        "Downloads".source = config.lib.file.mkOutOfStoreSymlink "/mnt/ssd-256gb/Downloads";
        "Pictures".source = config.lib.file.mkOutOfStoreSymlink "/mnt/ssd-256gb/Pictures";
        "Videos".source = config.lib.file.mkOutOfStoreSymlink "/mnt/ssd-256gb/Videos";
      };

      modules.optional.opencode.enable = true;
    };
  };
}
