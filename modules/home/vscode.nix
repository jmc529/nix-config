{ config, lib, pkgs, ... }:

let
  marketplace = pkgs.vscode-marketplace;
in
{
  programs.vscode = {
    enable = true;

    profiles.default = {
      extensions = with marketplace; [
        # general/editor/git/theme
        aaron-bond.better-comments
        anseki.vscode-color
        naumovs.color-highlight
        editorconfig.editorconfig
        esbenp.prettier-vscode
        dbaeumer.vscode-eslint
        mhutchie.git-graph
        waderyan.gitblame
        donjayamanne.githistory
        codezombiech.gitignore
        gruntfuggly.todo-tree
        wayou.vscode-todo-highlight
        davidanson.vscode-markdownlint
        yzhang.markdown-all-in-one
        mechatroner.rainbow-csv
        streetsidesoftware.code-spell-checker
        pkief.material-icon-theme
        benjaminmandersen.midnight-pastel
        simonsiefke.svg-preview
        markis.code-coverage
        christian-kohler.path-intellisense
        christian-kohler.npm-intellisense
        formulahendry.auto-close-tag
        formulahendry.code-runner
        doxundermoon.shell-format
        rohit-gohri.format-code-action
        rvest.vs-code-prettier-eslint

        # Python
        ms-python.python
        ms-python.vscode-pylance
        ms-python.debugpy
        ms-python.blackformatter
        ms-python.vsc-python-envs
        kevinrose.vsc-python-indent
        njpwerner.autodocstring

        # Frontend
        bradlc.vscode-tailwindcss
        svelte.svelte-vscode
        syler.sass-indented
        zignd.html-css-class-completion
        graphql.vscode-graphql
        graphql.vscode-graphql-syntax

        # Docker
        docker.docker
        ms-azuretools.vscode-docker
        ms-azuretools.vscode-containers
        ms-vscode-remote.remote-containers

        ms-vsliveshare.vsliveshare
      ];

      userSettings = {
        "workbench.colorTheme" = "Midnight Pastel";
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.startupEditor" = "none";

        "editor.fonFamily" = "'FireCode Nerd Font', monospace";
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.formatOnSaveMode" = "modifications";
        "editor.guides.bracketPairs" = "true";

        "git.autofetch" = "true";
        "git.confirmSync" = "false";
        "git.suggestSmartCommit" = "true";

        "telemetry.telemetryLevel" = "off";
        "explorer.confirmDelete" = "false";

        "[python]" = {
          "editor.formatOnType" = true;
          "editor.formatOnSave" = true;
          "editor.defaultFormatter" = "ms-python.blackformatter";
        };
      };
    };
  };
}
