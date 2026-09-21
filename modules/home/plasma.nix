{
  programs.plasma = {
    enable = true;

    configFile = {
      dolphinrc = {
        "KFileDialog Settings" = {
          "Places Icons Auto-resize" = false;
          "Places Icons Static Size" = 22;
        };
      };

      kcminputrc = {
        "Libinput/1267/12608/MSFT0001:00 04F3:3140 Mouse".NaturalScroll = false;
        "Libinput/1267/12608/MSFT0001:00 04F3:3140 Touchpad".ClickMethod = 2;
        "Libinput/1267/12608/MSFT0001:00 04F3:3140 Touchpad".NaturalScroll = true;
      };

      kded5rc.Module-browserintegrationreminder.autoload = false;

      kdeglobals = {
        General = {
          TerminalApplication = "ghostty";
          TerminalService = "ghostty.desktop";
        };

        "KFileDialog Settings" = {
          "Breadcrumb Navigation" = false;
          "Decoration position" = 0;
          "Show Inline Previews" = false;
          "Speedbar Width" = 214;
        };
      };

      kiorc.Confirmations.ConfirmEmptyTrash = false;

      ksplashrc.KSplash.Theme = "a2n.kuro.oled";

      kwinrc = {
        Effect-colorblindnesscorrection.Intensity = 0.15;
        Effect-colorblindnesscorrection.Mode = 1;
        Plugins.colorblindnesscorrectionEnabled = true;

        Effect-overview.BorderActivate = 9;
        NightColor.Active = true;
        Xwayland.Scale = 1.125;

        TouchEdges.Bottom = "ApplicationLauncher";

        Desktops = {
          Name_1 = "Main";
          Name_2 = "Dev";
          Name_3 = "Social";
          Name_4 = "Research";
          Number = 4;
          Rows = 2;
        };
      };

      plasmanotifyrc = {
        "Applications/Mailspring".Seen = true;
        "Applications/com.usebottles.bottles".Seen = true;
        "Applications/discord".Seen = true;
        "Applications/itch".Seen = true;
        "Applications/librewolf".Seen = true;
        "Applications/signal".Seen = true;
        "Applications/vesktop".Seen = true;
      };

      plasmaparc.General.RaiseMaximumVolume = true;
    };

    desktop.widgets = [
      {
        name = "org.kde.plasma.colorpicker";
        position = {
          horizontal = 10;
          vertical = 10;
        };
        size = {
          width = 50;
          height = 25;
        };
      }
    ];

    panels = [
      {
        location = "bottom";
        floating = true;
        widgets = [
          {
            name = "org.kde.plasma.kickoff";
            config = {
              General = {
                icon = "nix-snowflake-white";
                favoritesPortedToKAstats = true;
                systemFavorites = [ "suspend" "hibernate" "reboot" "shutdown" ];
              };
            };
          }

          {
            name = "org.kde.plasma.icontasks";
            config.General.launchers = [ ];
          }

          "org.kde.plasma.panelspacer"
          "org.kde.plasma.kvitals"
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.marginsseparator"

          {
            name = "org.muddyblack.gitpulse";
            config.General.accounts = builtins.toJSON [
              {
                id = "accyaf5l83k2a";
                provider = "github";
                host = "";
                token = "";
                graphqlToken = "";
                label = "";
                useCli = true;
                enabled = true;
              }
            ];
          }

          {
            name = "org.kde.plasma.systemtray";
            config.General = {
              extraItems = [
                "org.kde.plasma.cameraindicator"
                "org.kde.plasma.devicenotifier"
                "org.kde.plasma.manage-inputmethod"
                "org.kde.plasma.mediacontroller"
                "org.kde.plasma.clipboard"
                "org.kde.plasma.notifications"
                "org.kde.plasma.keyboardindicator"
                "org.kde.plasma.battery"
                "org.kde.kscreen"
                "org.kde.plasma.volume"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.keyboardlayout"
                "org.kde.plasma.printmanager"
              ];
              knownItems = [
                "org.kde.plasma.cameraindicator"
                "org.kde.plasma.devicenotifier"
                "org.kde.plasma.manage-inputmethod"
                "org.kde.plasma.mediacontroller"
                "org.kde.plasma.clipboard"
                "org.kde.plasma.notifications"
                "org.kde.plasma.keyboardindicator"
                "org.kde.plasma.battery"
                "org.kde.kscreen"
                "org.kde.plasma.volume"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.keyboardlayout"
                "org.kde.plasma.printmanager"
                "org.kde.plasma.brightness"
                "org.kde.plasma.bluetooth"
                "org.kde.plasma.weather"
              ];
            };
          }

          {
            name = "org.kde.plasma.digitalclock";
            config.Appearance.fontWeight = 400;
          }

          {
            name = "org.kde.plasma.pager";
            config.General.wrapPage = true;
          }
        ];
      }
    ];
  };
}
