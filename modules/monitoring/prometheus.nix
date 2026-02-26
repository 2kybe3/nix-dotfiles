{config, ...}: let
  inherit
    (config.kybe.lib.caddy)
    createCaddyProxy
    ;

  domain = "prometheus.${config.kybe.lib.domain}";
in {
  services.prometheus = {
    enable = true;
    port = 9001;
    webExternalUrl = domain;
    extraFlags = ["--web.enable-admin-api"];
    scrapeConfigs = [
      {
        job_name = "proxmox-node";
        static_configs = [
          {
            targets = ["10.0.5.1:9100"];
          }
        ];
        scrape_interval = "5s";
      }
      {
        job_name = "caddy";
        static_configs = [
          {
            targets = ["10.0.4.2:2019"];
          }
        ];
        scrape_interval = "5s";
      }
      {
        job_name = "caddy-internal";
        static_configs = [
          {
            targets = ["10.0.5.2:2019"];
          }
        ];
        scrape_interval = "5s";
      }
    ];
  };

  services.caddy.virtualHosts.${domain} = createCaddyProxy 9001;
}
