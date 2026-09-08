{
  imports = [
    ./apps.nix
    ./git.nix
    ./ide.nix
    ./librewolf.nix
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
    kitty.enable = true;
    obsidian.enable = true;
    opencode.enable = true;
    vscodium.enable = true;
    zellij.enable = true;
    librewolf = {
      enable = true;
      fonts.override = {
        sizes.applications = 12;
      };
    };
  };
}
