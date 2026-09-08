{
  programs.librewolf = {
    enable = true;
    settings = {
      "privacy.resistFingerprinting" = true; # spoof TZ & screen size
      "webgl.disabled" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "network.cookie.lifetimePolicy" = 0;
      "privacy.donottrackheader.enabled" = true;
      "network.dns.disablePrefetch" = true;
      "network.predictor.enabled" = false;
      "network.prefetch-next" = false;
      "signon.rememberSignons" = false;
      "browser.formfill.enable" = false;
      "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
      "browser.urlbar.suggest.searches" = false;
      "browser.urlbar.showSearchSuggestionsFirst" = false;
      "browser.startup.page" = 3;
      "browser.bookmarks.defaultLocation" = "toolbar_____";
      "browser.toolbars.bookmarks.visibility" = "never";
    };

    policies = {
      DisableTelemetry = true;
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = { # uBlock Origin
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "addon@darkreader.org" = { # Dark Reader
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = { # Bitwarden Password Manager
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
        "jid1-MnnxcxisBPnSXQ@jetpack" = { # Privacy Badger
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
        };
        "jid1-BoFifL9Vbdl2zQ@jetpack" = { # Decentraleyes
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/decentraleyes/latest.xpi";
          installation_mode = "force_installed";
        };
        "jid1-ZAdIEUB7XOzOJw@jetpack" = { # DuckDuckGo Search & Tracker Protection
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/duckduckgo-for-firefox/latest.xpi";
          installation_mode = "force_installed";
        };
        "extension@tabliss.io" = { # Tabliss
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/tabliss/latest.xpi";
          installation_mode = "force_installed";
        };
        "gdpr@cavi.au.dk" = { # Consent-O-Matic
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/consent-o-matic/latest.xpi";
          installation_mode = "force_installed";
        };
        "floccus@handmadeideas.org" = { # floccus bookmarks sync
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/floccus/latest.xpi";
          installation_mode = "force_installed";
        };
        "Tab-Session-Manager@sienori" = { # Tab Session Manager
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/tab-session-manager/latest.xpi";
          installation_mode = "force_installed";
        };
        "@testpilot-containers" = { # Firefox Multi-Account Containers
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
          installation_mode = "force_installed";
        };
        "{a0370179-acc3-452f-9530-246b6adb2768}" = { # Svelte Devtools
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/svelte-devtools/latest.xpi";
          installation_mode = "force_installed";
        };
        "jid1-KKzOGWgsW3Ao4Q@jetpack" = { # I don't care about cookies
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/i-dont-care-about-cookies/latest.xpi";
          installation_mode = "force_installed";
        };
        "{c84d89d9-a826-4015-957b-affebd9eb603}" = { # MAL-Sync
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/mal-sync/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };

    profiles.default = {
      isDefault = true;
      search = {
        default = "ddg";
        privateDefault = "ddg";
        force = true;
      };
      settings."browser.uiCustomization.state" = {
        placements = {
          nav-bar = [
            "back-button"
            "forward-button"
            "stop-reload-button"
            "customizableui-special-spring1"
            "urlbar-container"
            "customizableui-special-spring2"
            "personal-bookmarks"
            "customizableui-special-spring3"
            "downloads-button"
            "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action" # Bitwarden
            "tab-session-manager_sienori-browser-action" # Tab Session Manager
            "unified-extensions-button"
          ];
          PersonalToolbar = [ ];
          unified-extensions-area = [ ];
          toolbar-menubar = [ "menubar-items" ];
          TabsToolbar = [ "tabbrowser-tabs" "new-tab-button" "alltabs-button" ];
        };
        currentVersion = 26;
      };
    };
  };

  stylix.targets.librewolf.profileNames = [ "default" ];
}