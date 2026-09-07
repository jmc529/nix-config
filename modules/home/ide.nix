{ pkgs, ... }:

let
  marketplace = pkgs.vscode-marketplace;
in
{
  programs = {
    helix = {
      enable = true;
      settings = {
        editor.cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
      languages.language = [{
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
      }];
    };

    vscodium = {
      enable = true;
      package = pkgs.vscodium;
      
      profiles.default = {
        extensions = with marketplace; [
          # general/editor/git/theme
          aaron-bond.better-comments
          anseki.vscode-color
          naumovs.color-highlight
          editorconfig.editorconfig
          esbenp.prettier-vscode
          mhutchie.git-graph
          waderyan.gitblame
          donjayamanne.githistory
          codezombiech.gitignore
          gruntfuggly.todo-tree
          wayou.vscode-todo-highlight
          mechatroner.rainbow-csv
          streetsidesoftware.code-spell-checker
          pkief.material-icon-theme
          benjaminmandersen.midnight-pastel
          simonsiefke.svg-preview
          tenninebt.vscode-koverage
          christian-kohler.path-intellisense
          christian-kohler.npm-intellisense
          formulahendry.auto-close-tag
          formulahendry.code-runner
          foxundermoon.shell-format
          rohit-gohri.format-code-action

          # Python
          ms-python.python
          ms-python.vscode-pylance
          ms-python.debugpy
          ms-python.black-formatter
          ms-python.vscode-python-envs
          njpwerner.autodocstring

          # Frontend
          svelte.svelte-vscode
          zignd.html-css-class-completion

          # Docker
          docker.docker
          ms-azuretools.vscode-docker
          ms-azuretools.vscode-containers
          ms-vscode-remote.remote-containers

          ms-vsliveshare.vsliveshare

          # Nix
          jnoortheen.nix-ide
          
        ];

        userSettings = {
          # Set by stlyix 
          # "workbench.colorTheme" = "Midnight Pastel";
          "workbench.iconTheme" = "material-icon-theme";
          "workbench.startupEditor" = "none";

          # Set by stylix 
          # "editor.fontFamily" = "'FireCode Nerd Font', monospace";
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
          "editor.formatOnSaveMode" = "modifications";
          "editor.guides.bracketPairs" = true;

          "git.autofetch" = true;
          "git.confirmSync" = false;
          "git.suggestSmartCommit" = true;

          "telemetry.telemetryLevel" = "off";
          "explorer.confirmDelete" = false;

          "[python]" = {
            "editor.formatOnType" = true;
            "editor.formatOnSave" = true;
            "editor.defaultFormatter" = "ms-python.blackformatter";
          };

          "cSpell.userWords" = [
            "stylix"
            "pkgs"
          ];
        };
      };
    };
  };
}
