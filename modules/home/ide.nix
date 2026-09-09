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
          dbaeumer.vscode-eslint
          davidanson.vscode-markdownlint
          yzhang.markdown-all-in-one
          shd101wyy.markdown-preview-enhanced
          vivaxy.vscode-conventional-commits
          michaelcurrin.auto-commit-msg
          github.vscode-pull-request-github
          redhat.vscode-yaml
          oderwat.indent-rainbow
          shardulm94.trailing-spaces
          chrmarti.regex
          quicktype.quicktype
          jock.svg
          hediet.vscode-drawio
          randomfractalsinc.vscode-data-preview
          maziac.binary-file-viewer
          deibit.devdocs
          leetcode.vscode-leetcode
          circleci.circleci
          firefox-devtools.vscode-firefox-debug

          # Python
          ms-python.python
          ms-python.vscode-pylance
          ms-python.debugpy
          ms-python.black-formatter
          ms-python.vscode-python-envs
          ms-python.isort
          njpwerner.autodocstring

          # Frontend
          svelte.svelte-vscode
          ardenivanov.svelte-intellisense
          fivethree.vscode-svelte-snippets
          zignd.html-css-class-completion
          ecmel.vscode-html-css
          bradlc.vscode-tailwindcss
          vue.volar
          octref.vetur
          syler.sass-indented
          graphql.vscode-graphql
          graphql.vscode-graphql-syntax
          ritwickdey.liveserver
          ms-vscode.live-server

          # C/C++
          ms-vscode.cpptools
          ms-vscode.cpptools-extension-pack
          ms-vscode.cmake-tools
          twxs.cmake
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

          # LaTeX
          james-yu.latex-workshop

          # SQL / DB
          mtxr.sqltools
          alexcvzz.vscode-sqlite

          # Testing / coverage
          firsttris.vscode-jest-runner
          ryanluker.vscode-coverage-gutters
          markis.code-coverage
          hbenl.vscode-test-explorer
          ms-vscode.test-adapter-converter

          # Jupyter
          ms-toolsai.jupyter
          ms-toolsai.jupyter-keymap
          ms-toolsai.jupyter-renderers
          ms-toolsai.vscode-jupyter-cell-tags
          ms-toolsai.vscode-jupyter-slideshow

          # PDF
          tomoki1207.pdf

          # Docker
          docker.docker
          ms-azuretools.vscode-docker
          ms-azuretools.vscode-containers
          ms-vscode-remote.remote-containers

          # Remote
          ms-vscode-remote.remote-ssh
          ms-vscode-remote.remote-ssh-edit

          ms-vsliveshare.vsliveshare

          # Niche/hobby (ComputerCraft)
#           jackmacwindows.vscode-computercraft
          jackmacwindows.craftos-pc

          # Nix
          jnoortheen.nix-ide
        ];
      };
    };

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
      };
    };
  };
}
