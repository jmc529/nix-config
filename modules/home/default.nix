{
  imports = [
    ./apps.nix
    ./firefox.nix
    ./git.nix
    ./ide.nix
    ./plasma.nix
    ./shell.nix
    ./terminal.nix
  ];

  home.username = "joe";
  home.homeDirectory = "/home/joe";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  stylix.targets.kde.enable = true;
  stylix.targets.kitty.enable = true;
  stylix.targets.obsidian.enable = true;
  stylix.targets.opencode.enable = true;
  stylix.targets.vscodium.enable = true;
  stylix.targets.zellij.enable = true;
}
