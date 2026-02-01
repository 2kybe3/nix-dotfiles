{ config }:
rec {
  caddy = import ./caddy.nix { inherit config; };
  hostName = "${config.networking.hostName}";
  domain = "${hostName}.kybe.xyz";
}
