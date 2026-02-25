{
  containers.i2pd = {
    autoStart = true;
    ephemeral = true;

    config = {...}: {
      networking.firewall.allowedTCPPorts = [
        7070
        4444
      ];

      services.i2pd = {
        enable = true;
        address = "0.0.0.0";
        proto = {
          http.enable = true;
          httpProxy.enable = true;
        };
      };

      system.stateVersion = "25.11";
    };
  };
}
