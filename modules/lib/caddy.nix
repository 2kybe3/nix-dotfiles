{config}: let
  inherit
    (config.kybe.lib)
    domain
    ;
  certloc = "/var/lib/acme/${domain}";
in {
  createCaddyProxy = port: {
    extraConfig = ''
      encode
      tls ${certloc}/cert.pem ${certloc}/key.pem
      reverse_proxy localhost:${toString port}
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
