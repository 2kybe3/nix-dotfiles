{
  services.tor = {
    enable = true;
    client = {
      enable = true;
      dns.enable = true;
      socksListenAddress = {
        IsolateSOCKSAuth = true;
        addr = "127.0.0.1";
        port = 9050;
      };
    };
  };
}
