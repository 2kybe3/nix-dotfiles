{
  self,
  config,
  ...
}: {
  sops.secrets = {
    "wg-key" = {
      sopsFile = "${self}/secrets/wireguard.yaml";
      key = "key";
    };
    "wg-pk" = {
      sopsFile = "${self}/secrets/wireguard.yaml";
      key = "pk";
    };
  };

  systemd.services."kybe-wg-resolv" = {
    description = "Set resolvectl for kybe.xyz after wg interface is up";

    depends = ["network-online.targe"];
    after = ["network-online.target"];
    requires = ["wireguard-kybe.xyz.service"];
    partOf = ["wireguard-kybe.xyz.service"];
    wantedBy = ["wireguard-kybe.xyz.service"];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/bin/sh -c 'resolvectl dnsovertls kybe.xyz no; resolvectl dnssec kybe.xyz no; resolvectl domain kybe.xyz ~kybe.xyz; resolvectl dns kybe.xyz 10.0.6.1;'";
      RemainAfterExit = true;
    };
  };

  networking.wireguard.interfaces = {
    "kybe.xyz" = {
      ips = ["10.0.6.5/32"];
      privateKeyFile = config.sops.secrets."wg-key".path;

      peers = [
        {
          endpoint = "ip.kybe.xyz:51820";
          publicKey = "Dumq+QBDIAmAzTC1lo+njEh5v1ZJ+epGfxCheGWOsxc=";
          presharedKeyFile = config.sops.secrets."wg-pk".path;
          allowedIPs = [
            "10.0.4.0/23"
            "10.0.6.0/24"
          ];
          persistentKeepalive = 25;
        }
      ];

      postShutdown = ''
        resolvectl revert kybe.xyz || true
      '';
    };
  };
}
