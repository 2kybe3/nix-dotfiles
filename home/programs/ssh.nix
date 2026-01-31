{ config, ... }:
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "kybe.xyz" = {
        user = "root";
        identityFile = "${config.home.homeDirectory}/.ssh/kybe";
        identitiesOnly = true;
      };
    };
    enableDefaultConfig = false;
  };
}
