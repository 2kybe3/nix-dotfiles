{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    monero-cli
  ];
  services.monero = {
    enable = true;
    rpc = {
      address = "127.0.0.1";
      restricted = false;
      port = 18081;
    };
    dataDir = "/mnt/delta/monero";
    prune = true;
  };
}
