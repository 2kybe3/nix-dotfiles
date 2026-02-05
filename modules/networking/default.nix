{config, ...}: {
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [22];
      interfaces."kybe.xyz".allowedTCPPorts =
        if config.kybe.lib.hostName == "knx"
        then [3000]
        else [];
    };
    hosts."127.0.0.1" = [
      "*.${config.kybe.lib.domain}"
      "${config.kybe.lib.domain}"
    ];
  };

  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSSEC =
        if config.kybe.lib.hostName == "server"
        then "false"
        else "true";
      Domains = ["~."];
      DNSOverTLS = "false";
      DNS =
        if config.kybe.lib.hostName == "server"
        then [
          "10.0.4.1"
        ]
        else [
          "1.1.1.1"
          "1.0.0.1"
        ];
    };
  };
}
