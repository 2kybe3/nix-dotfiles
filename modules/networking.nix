{ config, ... }:
{
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "systemd-resolved";
  networking.firewall.allowedTCPPorts = [ 22 ];

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    dnsovertls = "false";
  };

  sops.secrets."wireguard/key" = { };
  sops.secrets."wireguard/pk" = { };

  networking.wg-quick.interfaces = {
    "kybe.xyz" = {
      address = [
        "10.0.6.5/32"
      ];
      dns = [
        "10.0.6.1"
      ];

      #### Tell resovectl to use 10.0.6.1 for anything kybe.xyz related #####
      postUp = ''
        resolvectl dnsovertls kybe.xyz no;
        resolvectl dnssec kybe.xyz no;
        resolvectl domain kybe.xyz ~kybe.xyz;
        resolvectl dns kybe.xyz 10.0.6.1;
      '';
      postDown = ''
        resolvectl revert %i
      '';

      #### My Server :-) #####
      peers = [
        {
          allowedIPs = [
            "10.0.4.0/23"
            "10.0.6.0/24"
          ];
          persistentKeepalive = 25;
          endpoint = "kybe.xyz:51820";
          publicKey = "Dumq+QBDIAmAzTC1lo+njEh5v1ZJ+epGfxCheGWOsxc=";
          presharedKeyFile = config.sops.secrets."wireguard/pk".path;
        }
      ];
      privateKeyFile = config.sops.secrets."wireguard/key".path;
    };
  };
}
