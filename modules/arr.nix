{ config, lib, ... }:
let
  domain = config.kybe.lib.domain;

  createCaddyProxy = config.kybe.lib.caddy.createCaddyProxy;
in
{
  services = {
    sonarr.enable = true;
    radarr.enable = true;
    prowlarr.enable = true;
    bazarr.enable = true;
    flaresolverr.enable = true;
    readarr = {
      enable = false; # TODO
      user = if config.services.calibre-server.enable then config.calibre-server.user else "readarr";
    };

    
    caddy.virtualHosts = {
      "sonarr.${domain}" = createCaddyProxy 8989;
      "radarr.${domain}" = createCaddyProxy 7878;
      "prowlarr.${domain}" = createCaddyProxy 9696;
      "bazarr.${domain}" = createCaddyProxy 6767;
      "flaresolverr.${domain}" = createCaddyProxy 8191;
      "readarr.${domain}" = createCaddyProxy 8787;
    };
  };

  systemd.services.prowlarr.serviceConfig.DynamicUser = lib.mkForce false;
  systemd.services.bazarr.serviceConfig.DynamicUser = lib.mkForce false;
}
