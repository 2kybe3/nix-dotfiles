{config, ...}: {
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "kybe.xyz" = {
        user = "root";
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
