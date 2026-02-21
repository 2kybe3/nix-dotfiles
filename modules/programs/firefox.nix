{
  pkgs,
  config,
  ...
}: let
  sonarrDomain = "sonarr.server.${config.kybe.lib.baseDomain}";
  radarrDomain = "radarr.server.${config.kybe.lib.baseDomain}";
in {
  programs = {
    firefox = {
      enable = true;
      nativeMessagingHosts.packages = [
        pkgs.keepassxc
      ];

      languagePacks = [
        "de"
        "en-US"
      ];

      policies = {
        AppAutoUpdate = false;
        BackgroundAppUpdate = false;
        DisablePocket = true;
        DisableAccounts = true;
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        DisableFirefoxAccounts = true;
        DontCheckDefaultBrowser = true;
        DisableFormHistory = true;
        DisableProfileImport = true;
        DisableProfileRefresh = true;
        DisableSetDesktopBackground = true;
        DisableFirefoxScreenshots = true;
        DisplayBookmarksToolbar = "never";
        OfferToSaveLogins = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
          EmailTracking = true;
        };
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";

        ExtensionSettings = {
          "*".installation_mode = "blocked";
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          "jid1-MnnxcxisBPnSXQ@jetpack" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
            installation_mode = "force_installed";
          };
          "keepassxc-browser@keepassxc.org" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
            installation_mode = "force_installed";
          };
          # "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          #   installation_mode = "force_installed";
          # };
        };
        Preferences = {
          "browser.search.suggest.enabled" = false;
          "browser.search.suggest.enabled.private" = false;

          "browser.urlbar.suggest.searches" = false;
          "browser.urlbar.showSearchSuggestionsFirst" = false;

          "browser.newtabpage.activity-stream.feeds.snippets" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.system.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;

          "network.http.sendRefererHeader" = "1";

          "privacy.resistFingerprinting" = true;
          "privacy.resistFingerprinting.exemptedDomains" = "*.youtube.com";

          "geo.enabled" = false;
          "dom.battery.enabled" = false;
          "device.sensors.enabled" = false;

          # Tweak to make keepasses PassKeys work
          "security.webauth.webauthn_enable_usbtoken" = false;
        };

        SearchEngines = {
          PreventInstalls = true;
          Default = "searxng";
          Add = [
            {
              Alias = "@s";
              Description = "Search";
              IconURL = "https://search.kybe.xyz/favicon.ico";
              Method = "POST";
              Name = "searxng";
              URLTemplate = "https://search.kybe.xyz/search";
              PostData = "q={searchTerms}";
            }
            {
              Alias = "@nix";
              Description = "Search MyNixOS";
              IconURL = "https://nixos.org/favicon.ico";
              Method = "GET";
              Name = "MyNixOS";
              URLTemplate = "https://mynixos.com/search?q={searchTerms}";
            }
            {
              Alias = "@ym";
              Description = "Search Youtube Music";
              IconURL = "https://music.youtube.com/favicon.ico";
              Method = "GET";
              Name = "Youtube Music";
              URLTemplate = "https://music.youtube.com/search?q={searchTerms}";
            }
            {
              Alias = "@yt";
              Description = "Search YouTube";
              IconURL = "https://www.youtube.com/favicon.ico";
              Method = "GET";
              Name = "Youtube";
              URLTemplate = "https://www.youtube.com/results?search_query={searchTerms}";
            }
            {
              Alias = "@rr";
              Description = "Search Radarr for Movies";
              IconURL = "https://${radarrDomain}/favicon.ico";
              Method = "GET";
              Name = "Radarr";
              URLTemplate = "https://${radarrDomain}/add/new?term={searchTerms}";
            }
            {
              Alias = "@sr";
              Description = "Search Sonarr for Movies";
              IconURL = "https://${sonarrDomain}/favicon.ico";
              Method = "GET";
              Name = "Sonarr";
              URLTemplate = "https://${sonarrDomain}/add/new?term={searchTerms}";
            }
          ];
          Remove = [
            "Google"
            "Bing"
            "Ecosia"
            "Perplexity"
            "Wikipedia (en)"
          ];
        };
      };
    };
  };
}
