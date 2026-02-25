{self,pkgs,config,...}:
let
  inherit
    (config.kybe.lib)
    domain
    hostName
    ;
  inherit
    (config.kybe.lib.caddy)
    createCaddyProxy
    ;

  grafanaDomain = "grafana.${domain}";
in {
  sops.secrets.grafana = {
    sopsFile = "${self}/secrets/monitoring.yaml";
  };

  services.grafana = {
    enable = true;

    addr = "127.0.0.1";
    port = 2342;

    domain = grafanaDomain;
    settings.server.security.secret_key = "$__file{${config.sops.secrets.grafana.path}}";
  };

  services.caddy.virtualHosts = {
    ${grafanaDomain} = createCaddyProxy 2342;
  };
}
