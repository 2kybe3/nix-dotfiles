{ config }:
{
  caddy = import ./caddy.nix { inherit config; };
}
