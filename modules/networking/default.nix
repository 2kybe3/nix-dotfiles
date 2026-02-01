{ config, ... }:
{
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22 # SSH
      ];
      interfaces."kybe.xyz".allowedTCPPorts = (
        if config.kybe.lib.hostName == "knx" then [ 3000 ] else [ ]
      );
    };
    hosts = {
      "127.0.0.1" = [
        "*.${config.kybe.lib.domain}"
        "${config.kybe.lib.domain}"
      ];
    };
  };

  services.resolved = {
    enable = true;
    settings = {
      Resolve = {
        DNSSEC = "true";
        Domains = [ "~." ];
        DNSOverTLS = "false";
        FallbackDNS = (
          if config.kybe.lib.hostName == "server" then
            [ "10.0.4.1" ]
          else
            [
              "1.1.1.1"
              "1.0.0.1"
            ]
        );
      };
    };
  };
}
