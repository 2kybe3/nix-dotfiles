{
  self,
  config,
  ...
}: let
  inherit
    (config.kybe.lib.caddy)
    createCaddyProxy
    ;

  domain = "prometheus.${config.kybe.lib.domain}";
in {
  sops.secrets = {
    syncthing-api-server = {
      sopsFile = "${self}/secrets/syncthing-api.yaml";
      owner = "prometheus";
      key = "server";
    };
    syncthing-api-knx = {
      sopsFile = "${self}/secrets/syncthing-api.yaml";
      owner = "prometheus";
      key = "knx";
    };
  };
  services.prometheus = {
    enable = true;
    port = 9001;
    webExternalUrl = domain;
    extraFlags = ["--web.enable-admin-api"];
    checkConfig = "syntax-only";
    scrapeConfigs = [
      {
        job_name = "proxmox-node";
        scrape_interval = "5s";
        static_configs = [
          {
            targets = ["10.0.5.1:9100"];
          }
        ];
      }
      {
        job_name = "caddy";
        scrape_interval = "5s";
        static_configs = [
          {
            targets = ["10.0.4.2:2019"];
          }
        ];
      }
      {
        job_name = "caddy-internal";
        scrape_interval = "5s";
        static_configs = [
          {
            targets = ["10.0.5.2:2019"];
          }
        ];
      }
      {
        job_name = "syncthing-server";
        scrape_interval = "5s";
        scheme = "https";
        static_configs = [
          {
            targets = ["syncthing.server.kybe.xyz"];
          }
        ];
        authorization.credentials_file = config.sops.secrets.syncthing-api-server.path;
      }
      {
        job_name = "syncthing-knx";
        scrape_interval = "5s";
        scheme = "https";
        static_configs = [
          {
            targets = ["syncthing.knx.kybe.xyz"];
          }
        ];
        authorization.credentials_file = config.sops.secrets.syncthing-api-knx.path;
      }
    ];
  };

  services.caddy.virtualHosts.${domain} = createCaddyProxy 9001;
}
