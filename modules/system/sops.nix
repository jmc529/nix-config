{ inputs, config, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.sops
    pkgs.ssh-to-age
  ];

  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  sops.defaultSopsFile = "${inputs.self}/secrets.yaml"; # adjust to actual repo-root-relative path
  sops.secrets."vscodium-token" = {
    owner = "joe";
  };
}