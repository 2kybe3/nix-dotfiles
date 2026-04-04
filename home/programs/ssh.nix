{ config, ... }:
{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "ip.kybe.xyz" = {
        user = "kybe";
        identityFile = "${config.home.homeDirectory}/.ssh/kybe";
        identitiesOnly = true;
      };
      "gitc" = {
        hostname = "gitc.kybe.xyz";
        user = "git";
      };
    };

    enableDefaultConfig = false;
  };
}
