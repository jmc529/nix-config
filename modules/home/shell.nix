{
  programs = { 
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        ls = "eza -l";
      };
    };
  
    starship = {
      enable = true;
      enableZshIntegration = true;
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
  };
}
