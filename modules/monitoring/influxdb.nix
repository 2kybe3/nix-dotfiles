{
  self,
  config,
  ...
}: let
  inherit
    (config.kybe.lib.caddy)
    createCaddyProxy
    ;

  domain = "influxdb.${config.kybe.lib.domain}";
in {
  sops.secrets = {
    influxdb-pass = {
      sopsFile = "${self}/secrets/influxdb.yaml";
      owner = "influxdb2";
      key = "pass";
    };
    influxdb-token = {
      sopsFile = "${self}/secrets/influxdb.yaml";
      owner = "influxdb2";
      key = "token";
    };
  };
  services.influxdb2 = {
    enable = true;
    provision = {
      enable = true;
      initialSetup = {
        organization = "main";
        bucket = "main";
        username = "kybe";
        retention = 90 * 24 * 60 * 60;
        passwordFile = config.sops.secrets.influxdb-pass.path;
        tokenFile = config.sops.secrets.influxdb-token.path;
      };
    };
  };

  services.caddy.virtualHosts.${domain} = createCaddyProxy 9000;
}
