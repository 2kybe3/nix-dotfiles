{ config, ... }:
let
  domain = config.kybe.lib.domain;
  createRawCaddyProxy = config.kybe.lib.caddy.createRawCaddyProxy;
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
      postRun = ''
        chmod g+rwx .
        chmod g+rwx key.pem cert.pem
      '';
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
    };
  };

  users.groups.acme.members = [
    "caddy"
  ];
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
