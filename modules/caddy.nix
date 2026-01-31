{ config, ... }:
let
  domain = "knx.kybe.xyz";
  certloc = "/var/lib/acme/knx.kybe.xyz";
in
{
  sops.secrets.acme = {
    sopsFile = ../secrets/acme.env.bin;
    format = "binary";
  };

  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "kybe@kybe.xyz";
      credentialsFile = config.sops.secrets.acme.path;
      dnsProvider = "cloudflare";
      dnsResolver = "1.1.1.1:53";
      dnsPropagationCheck = true;
    };

    certs."${domain}" = {
      domain = "${domain}";
      extraDomainNames = [ "*.${domain}" ];
    };
  };

  services.caddy = {
    enable = true;

    virtualHosts = {
      "${domain}".extraConfig = ''
        encode
        tls ${certloc}/cert.pem ${certloc}/key.pem

        respond "KNX"
      '';
      "syncthing.${domain}".extraConfig = ''
        encode
        tls ${certloc}/cert.pem ${certloc}/key.pem

        reverse_proxy http://localhost:8383
      '';
    };
  };

  users.groups.acme.members = [
    "caddy"
  ];
  networking.firewall.interfaces."kybe.xyz".allowedTCPPorts = [
    80
    443
  ];
}
