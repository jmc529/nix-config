{
  programs.plasma = {
    enable = true;

    configFile = {
      kcminputrc = {
        "Libinput/1267/12608/MSFT0001:00 04F3:3140 Mouse".NaturalScroll = false;
        "Libinput/1267/12608/MSFT0001:00 04F3:3140 Touchpad".ClickMethod = 2;
        "Libinput/1267/12608/MSFT0001:00 04F3:3140 Touchpad".NaturalScroll = true;
      };
    
      kwinrc = {
        Effect-colorblindnesscorrection.Intensity = 0.15;
        Effect-colorblindnesscorrection.Mode = 1;
        Plugins.colorblindnesscorrectionEnabled  = true;

        TouchEdges.Bottom = "ApplicationLauncher";

        Desktops = {
          Id_1 = "cb8c7fe7-4c9b-4180-90b9-3402cf334ad0";
          Id_2 = "3851be88-a805-490d-ae01-b98d88171a5e";
          Id_3 = "29f89636-53be-4944-9183-d3283580fe83";
          Id_4 = "d42b8903-8506-485c-8743-2d39ffd7be80";
          Name_1 = "Main";
          Name_2 = "Dev";
          Name_3 = "Social";
          Name_4 = "Research";
          Number = 4;
          Rows = 2;
        };
      };
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
                "com.github.k-donn.plasmoid-wunderground"
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
              shownItems = [ "com.github.k-donn.plasmoid-wunderground" ];
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
