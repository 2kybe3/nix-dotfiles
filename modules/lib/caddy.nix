{ config }:
let
  domain = "${config.networking.hostName}.kybe.xyz";
  certloc = "/var/lib/acme/${domain}";
in
{
  domain = domain;
  certloc = certloc;
  createCaddyProxy = port: {
    extraConfig = ''
      encode
      tls ${certloc}/cert.pem ${certloc}/key.pem
      reverse_proxy localhost:${port}
    '';
  };
  createRawCaddyProxy = block: {
    extraConfig = ''
      encode
      tls ${certloc}/cert.pem ${certloc}/key.pem

      ${block}
    '';
  };
}
