{
  config,
  pkgs,
}: rec {
  caddy = import ./caddy.nix {inherit config;};
  firejail = import ./firejail.nix {inherit pkgs;};
  hostName = "${config.networking.hostName}";
  baseDomain = "kybe.xyz";
  domain = "${config.kybe.lib.hostName}.${baseDomain}";
}
