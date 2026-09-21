{
  programs.git = {
    enable = true;

    ignores = [
      ".cache/"
      ".direnv/"
      "node_modules"

      ".DS_Store"
      ".idea"
      "*.swp"
      "*.elc"

      "result"
      "result-*"

      "auto-save-list"
    ];

    settings = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push = { autoSetupRemote = true; };
      user = {
        name = "jmc529";
        email = "jmc529@users.noreply.github.com";
      };

    };
  };
}
