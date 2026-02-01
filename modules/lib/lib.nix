{ config }:
{
  caddy = import ./caddy.nix { inherit config; };
  hostName = "${config.networking.hostName}";
  domain = "${config.kybe.lib.hostName}.kybe.xyz";
}
