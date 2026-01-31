{ pkgs, ... }:
let
  baseDomain = "knx.kybe.xyz";
in
{
  services.caddy = {
    enable = true;

    virtualHosts = {
      "syncthing.${baseDomain}:80" = {
        extraConfig = ''
          encode gzip
          reverse_proxy http://localhost:8383
        '';
      };
    };
  };
  networking.firewall.interfaces."kybe.xyz".allowedTCPPorts = [
    80
  ];
}
