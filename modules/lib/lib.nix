{
  config,
  pkgs,
}: {
  caddy = import ./caddy.nix {inherit config;};
  firejail = import ./firejail.nix {inherit pkgs;};
  hostName = "${config.networking.hostName}";
  domain = "${config.kybe.lib.hostName}.kybe.xyz";
}
