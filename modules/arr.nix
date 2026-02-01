{ config, ... }:
let
  domain = config.kybe.lib.domain;
  createCaddyProxy = config.kybe.lib.caddy.createCaddyProxy;
in
{
  users.groups.media = { };

  systemd.tmpfiles.rules = [
    "d /media 0775 root media -"
    "d /media/sonarr 0775 root media -"
    "d /media/radarr 0775 root media -"
  ];

  services = {
    jellyfin = {
      enable = true;
      group = "media";
    };

    sonarr = {
      enable = true;
      group = "media";
    };
    radarr = {
      enable = true;
      group = "media";
    };
    prowlarr.enable = true;


    bazarr = {
      enable = true;
      group = "media";
    };
    jackett = {
      enable = true;
      group = "media";
    };

    flaresolverr.enable = true;

    readarr = {
      enable = false; # TODO
      user = if config.services.calibre-server.enable then config.calibre-server.user else "readarr";
    };
    
    caddy.virtualHosts = {
      "jellyfin.${domain}" = createCaddyProxy 5055;

      "sonarr.${domain}" = createCaddyProxy 8989;
      "radarr.${domain}" = createCaddyProxy 7878;
      "prowlarr.${domain}" = createCaddyProxy 9696;

      "bazarr.${domain}" = createCaddyProxy 6767;
      "jackett.${domain}" = createCaddyProxy 9117;

      "flaresolverr.${domain}" = createCaddyProxy 8191;

      "readarr.${domain}" = createCaddyProxy 8787;
    };
  };
}
