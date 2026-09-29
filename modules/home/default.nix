{ osConfig, config, lib, pkgs, ... }:

{
  imports = [
    ./apps.nix
    ./git.nix
    ./ide.nix
    ./librewolf.nix
    ./nixcord.nix
    ./plasma.nix
    ./shell.nix
    ./terminal.nix
  ];

  home = {
    username = "joe";
    homeDirectory = "/home/joe";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;

  stylix.targets = {
    kde.enable = true;
    ghostty.enable = true;
    obsidian.enable = true;
    opencode.enable = true;
    vscodium.enable = true;
    librewolf = {
      enable = true;
      fonts.override = {
        sizes.applications = 12;
      };
    };
  };

  # Inject circleci token into vscodium at runtime
  home.activation.vscodium-circleci-token = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    token=${lib.escapeShellArg osConfig.age.secrets.circleci-api-token.path}
    settings=${lib.escapeShellArg "${config.xdg.configHome}/VSCodium/User/settings.json"}
    if [ -s "$token" ]; then
      mkdir -p -- "$(dirname -- "$settings")"
      ${lib.getExe pkgs.jq} -e . "$settings" >/dev/null 2>&1 || printf '{}\n' > "$settings"
      candidate=$(mktemp "$settings.candidate.XXXXXX")
      ${lib.getExe pkgs.jq} --rawfile token "$token" '. + { "circleci.hostUrl": "",
        "circleci.apiToken": ($token | rtrimstr("\n")) }' "$settings" > "$candidate"
      mv -f -- "$candidate" "$settings"
    fi
  '';
}
