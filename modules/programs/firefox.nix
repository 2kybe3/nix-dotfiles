{pkgs, ...}: {
  programs.firefox = {
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
        Add = [
          {
            Alias = "@np";
            Description = "Search in NixOS Packages";
            IconURL = "https://nixos.org/favicon.png";
            Method = "GET";
            Name = "NixOS Packages";
            URLTemplate = "https://search.nixos.org/packages?from=0&size=200&sort=relevance&type=packages&query={searchTerms}";
          }
          {
            Alias = "@no";
            Description = "Search in NixOS Options";
            IconURL = "https://nixos.org/favicon.png";
            Method = "GET";
            Name = "NixOS Options";
            URLTemplate = "https://search.nixos.org/options?from=0&size=200&sort=relevance&type=packages&query={searchTerms}";
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
}
