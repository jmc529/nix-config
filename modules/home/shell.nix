{ inputs, ... }:

{
  programs = { 
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
      };

      shellAliases = {
        ls = "eza --icons=auto";
        cd = "z";
      };
    };
  
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = builtins.fromTOML (builtins.readFile "${inputs.self}/assets/starship.toml");
    };
  
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  
    eza = {
      enable = true;
      enableZshIntegration = true;
    };

    pyenv = {
      enable = true;
      enableZshIntegration = true;
    };

    npm = {
      enable = true;
    };
  };
}
