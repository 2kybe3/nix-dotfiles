{
  self,
  pkgs,
  lib,
  config,
  ...
}: let
  inherit
    (config.kybe.lib)
    hostName
    ;
in {
  environment.systemPackages = with pkgs; [
    age
    sops
  ];
  sops = {
    defaultSopsFile = "${self}/secrets/secrets.yaml";
    defaultSopsFormat = "yaml";

    age.keyFile = "/nix/persist/var/lib/sops-nix/key.txt";

    secrets = lib.mkIf (hostName == "knx") {
      keepass = {
        sopsFile = "${self}/secrets/keepass.yaml";
        key = "key";
      };
    };
  };
}
