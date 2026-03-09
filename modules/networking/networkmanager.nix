{
  self,
  config,
  ...
}: {
  sops.secrets.wifi = {
    sopsFile = "${self}/secrets/wifi.yaml";
    key = "key";
  };

  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
    wifi.macAddress = "7A:3F:C2:91:4D:19";
    ensureProfiles = {
      secrets.entries = [
        {
          file = config.sops.secrets.wifi.path;
          key = "psk";
          matchId = "FRITZ!Box 6660 Cable QB";
          matchSetting = "wifi-security";
          matchType = "wifi";
        }
      ];
      profiles."FRITZ!Box 6660 Cable QB" = {
        connection = {
          id = "FRITZ!Box 6660 Cable QB";
          interface-name = "wlp0s20u2";
          timestamp = "1773077219";
          type = "wifi";
          uuid = "6e318787-4e73-426c-87c2-51d0c5bb087d";
        };
        ipv4 = {
          ignore-auto-dns = true;
          method = "auto";
        };
        ipv6 = {
          addr-gen-mode = "default";
          ignore-auto-dns = true;
          method = "auto";
        };
        wifi = {
          mode = "infrastructure";
          ssid = "FRITZ!Box 6660 Cable QB";
        };
        wifi-security = {
          auth-alg = "open";
          key-mgmt = "wpa-psk";
        };
      };
    };
  };
}
