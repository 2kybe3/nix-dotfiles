{config,pkgs,...}:
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
  services.grafana = {
    enable = true;
    domain = grafanaDomain;
    port = 2342;
    addr = "127.0.0.1";
  };

  services.caddy.virtualHosts = {
    ${grafanaDomain} = createCaddyProxy 2342;
  };
}
