{pkgs, ...}: let
  sonarrDomain = "sonarr.server.kybe.xyz";
  radarrDomain = "radarr.server.kybe.xyz";
in {
  programs.librewolf = {
    enable = true;
    nativeMessagingHosts = [
      pkgs.keepassxc
    ];

    languagePacks = [
      "de"
      "en-US"
    ];

    policies = {
      DisplayBookmarksToolbar = "never";

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
        "@testpilot-containers" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
          installation_mode = "force_installed";
        };
      };
      Preferences = {
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

    settings = {
      "network.http.referer.XOriginPolicy" = 2;
      "media.autoplay.blocking_policy" = 2;

      "privacy.fingerprintingProtection" = true;
      "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme";

      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "network.cookie.lifetimePolicy" = 0;
    };
  };
}
