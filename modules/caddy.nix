{ config, ... }:
let
  domain = config.kybe.lib.caddy.domain;
  certloc = config.kybe.lib.caddy.certloc;
  createCaddyProxy = config.kybe.lib.caddy.createCaddyProxy;
  createRawCaddyProxy = config.kybe.lib.caddy.createCaddyProxy;
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
      "${domain}" = createRawCaddyProxy ''respond "KNX"'';
      "syncthing.${domain}" = createCaddyProxy "8383";
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
