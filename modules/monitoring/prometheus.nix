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
    kybe-backend-api = {
      sopsFile = "${self}/secrets/kybe-backend.yaml";
      owner = "prometheus";
      key = "key";
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
        scrape_interval = "2s";
        static_configs = [
          {
            targets = ["10.0.5.1:9100"];
          }
        ];
      }
      {
        job_name = "caddy";
        scrape_interval = "1s";
        static_configs = [
          {
            targets = ["10.0.4.2:2019"];
          }
        ];
      }
      {
        job_name = "caddy-internal";
        scrape_interval = "1s";
        static_configs = [
          {
            targets = ["10.0.5.2:2019"];
          }
        ];
      }
      {
        job_name = "syncthing-server";
        scrape_interval = "1s";
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
        scrape_interval = "1s";
        scheme = "https";
        static_configs = [
          {
            targets = ["syncthing.knx.kybe.xyz"];
          }
        ];
        authorization.credentials_file = config.sops.secrets.syncthing-api-knx.path;
      }
      {
        job_name = "kybe-backend";
        scrape_interval = "1s";
        scheme = "https";
        static_configs = [
          {
            targets = ["kybe.xyz"];
          }
        ];
        authorization.credentials_file = config.sops.secrets.kybe-backend-api.path;
      }
    ];
  };

  services.caddy.virtualHosts.${domain} = createCaddyProxy 9001;
}
