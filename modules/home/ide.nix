{ osConfig, config, lib, pkgs, ... }:

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
        userSettings = {
          # Set by stylix
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

        extensions = with marketplace; [
          # general/editor/git/theme
          gruntfuggly.todo-tree
          aaron-bond.better-comments
          oderwat.indent-rainbow
          naumovs.color-highlight
          mechatroner.rainbow-csv
          shardulm94.trailing-spaces
          streetsidesoftware.code-spell-checker
          editorconfig.editorconfig
          esbenp.prettier-vscode
          dbaeumer.vscode-eslint
          chrmarti.regex
          pkief.material-icon-theme
          christian-kohler.path-intellisense
          christian-kohler.npm-intellisense
          formulahendry.auto-close-tag
          deibit.devdocs
          leetcode.vscode-leetcode
          ms-vsliveshare.vsliveshare

          # Git
          waderyan.gitblame
          donjayamanne.githistory
          codezombiech.gitignore

          # Python
          ms-python.python
          ms-python.vscode-pylance
          ms-python.debugpy
          ms-python.black-formatter
          ms-python.vscode-python-envs
          ms-python.isort
          njpwerner.autodocstring

          # Frontend
          firefox-devtools.vscode-firefox-debug
          circleci.circleci
          svelte.svelte-vscode
          ardenivanov.svelte-intellisense
          fivethree.vscode-svelte-snippets
          zignd.html-css-class-completion
          ecmel.vscode-html-css
          bradlc.vscode-tailwindcss
          syler.sass-indented
          graphql.vscode-graphql
          graphql.vscode-graphql-syntax
          ritwickdey.liveserver

          # C/C++
          ms-vscode.cpptools
          ms-vscode.cpptools-extension-pack
          ms-vscode.cmake-tools
          ms-vscode.makefile-tools
          jeff-hykin.better-cpp-syntax
          cschlosser.doxdocgen

          # Java
          redhat.java
          vscjava.vscode-java-pack
          vscjava.vscode-java-dependency
          vscjava.vscode-maven
          vscjava.vscode-gradle

          # C#/.NET
          ms-dotnettools.csharp
          ms-dotnettools.vscode-dotnet-runtime

          # Scala/Lua/Teal
          scala-lang.scala
          sumneko.lua
          pdesaulniers.vscode-teal
          (jackmacwindows.vscode-computercraft.overrideAttrs {postInstall = "";})
          jackmacwindows.craftos-pc

          # SQL / DB
          mtxr.sqltools
          alexcvzz.vscode-sqlite

          # Testing / coverage
          firsttris.vscode-jest-runner
          ryanluker.vscode-coverage-gutters
          hbenl.vscode-test-explorer
          ms-vscode.test-adapter-converter
          tenninebt.vscode-koverage

          # Jupyter
          ms-toolsai.jupyter
          ms-toolsai.jupyter-keymap
          ms-toolsai.jupyter-renderers
          ms-toolsai.vscode-jupyter-cell-tags
          ms-toolsai.vscode-jupyter-slideshow

          # Data/Text - PDF/MD/Latex/SVG
          tomoki1207.pdf
          jock.svg
          simonsiefke.svg-preview
          randomfractalsinc.vscode-data-preview
          maziac.binary-file-viewer
          hediet.vscode-drawio
          james-yu.latex-workshop
          foxundermoon.shell-format
          davidanson.vscode-markdownlint
          shd101wyy.markdown-preview-enhanced
          redhat.vscode-yaml

          # Docker
          docker.docker
          ms-azuretools.vscode-containers
          ms-vscode-remote.remote-containers

          # Nix
          jnoortheen.nix-ide
          bbenoist.nix
        ];
      };
    };
  };

  home.file."${config.xdg.configHome}/VSCodium/User/settings.json".source = lib.mkForce (
    config.lib.file.mkOutOfStoreSymlink
      osConfig.sops.templates."vscodium-settings.json".path
  );
}
