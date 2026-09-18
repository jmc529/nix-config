{ inputs, config, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.sops
    pkgs.ssh-to-age
  ];

  sops = {
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    defaultSopsFile = "${inputs.self}/secrets/sops.yaml";

    secrets."vscodium-token" = {
      owner = "joe";
    };

    templates."vscodium-settings.json" = {
      owner = "joe";
      content = builtins.toJSON (
        config.home-manager.users.joe.programs.vscodium.profiles.default.userSettings
        // {
          "circleci.hostUrl" = "";
          "circleci.apiToken" = config.sops.placeholder."vscodium-token";
        }
      );
    };
  };
}