{config, ...}: {
  sops.secrets = {
    "wg-key" = {
      sopsFile = ../../secrets/wireguard.yaml;
      key = "key";
    };
    "wg-pk" = {
      sopsFile = ../../secrets/wireguard.yaml;
      key = "pk";
    };
  };

  systemd.services."kybe-wg-resolv" = {
    description = "Set resolvectl for kybe.xyz after wg interface is up";
    after = [
      "network-online.target"
      "wireguard-kybe.xyz-peer-Dumq\x2bQBDIAmAzTC1lo\x2bnjEh5v1ZJ\x2bepGfxCheGWOsxc\x3d.service"
    ];
    wants = [
      "network-online.target"
      "wireguard-kybe.xyz-peer-Dumq\x2bQBDIAmAzTC1lo\x2bnjEh5v1ZJ\x2bepGfxCheGWOsxc\x3d.service"
    ];
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
