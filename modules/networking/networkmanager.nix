{
  self,
  config,
  ...
}:
{
  sops.secrets.wifi = {
    sopsFile = "${self}/secrets/wifi.env.bin";
    format = "binary";
  };

  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
    ensureProfiles = {
      environmentFiles = [ config.sops.secrets.wifi.path ];
      profiles = {
        "kybe" = {
          connection = {
            id = "kybe";
            interface-name = "wlp0s20u2";
            type = "wifi";
            uuid = "2e3b1f20-0c7d-4594-9234-a9427e3b8274";
          };
          ipv4 = {
            method = "auto";
          };
          ipv6 = {
            addr-gen-mode = "default";
            method = "auto";
          };
          wifi = {
            mode = "infrastructure";
            ssid = "kybe";
          };
          wifi-security = {
            key-mgmt = "sae";
            psk = "$KYBE_KEY";
          };
        };
        "FRITZ!Box 6660 Cable QB" = {
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
            psk = "$HOME_KEY";
          };
        };
      };
    };
  };
}
