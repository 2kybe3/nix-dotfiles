{
  networking.firewall.extraInputRules = ''
    # External traffic to containers
    tcp dport 7070 dnat to 10.233.1.2:7070
    tcp dport 4444 dnat to 10.233.1.2:4444

    # Hairpin NAT (localhost access)
    iif "lo" tcp dport 7070 dnat to 10.233.1.2:7070
    iif "lo" tcp dport 4444 dnat to 10.2333.1.2:4444

    # Ensure container replies reach host correctly
    oif "lo" tcp saddr 10.233.1.2 dport { 7070, 4444 } snat to 127.0.0.1
  '';

  containers.i2pd = {
    autoStart = true;
    ephemeral = true;

    privateNetwork = true;
    hostAddress = "10.233.1.1";
    localAddress = "10.233.1.2";
    
    config = { ... }: {
      networking.firewall.allowedTCPPorts = [
        7070
        4444
      ];

      services.i2pd = {
        enable = true;
        address = "0.0.0.0";
        proto = {
          http = {
            enable = true;
            address = "0.0.0.0";
            hostname = "localhost";
          };
          httpProxy = {
            enable = true;
            address = "0.0.0.0";
          };
        };
      };

      system.stateVersion = "25.11";
    };
  };
}
