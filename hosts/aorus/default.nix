{ inputs, ... }:

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
