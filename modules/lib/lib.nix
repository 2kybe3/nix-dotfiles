{ config }:
{
  caddy = import ./caddy.nix { inherit config; };
  domain = "${config.networking.hostName}.kybe.xyz";
}
