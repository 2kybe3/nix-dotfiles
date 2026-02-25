{config, ...}: {
  boot = {
    supportedFilesystems = ["ntfs"];
    stage2Greeting = "<<< ${config.kybe.lib.hostName}: ${config.system.nixos.distroName} Stage 2 :-) >>>";
    tmp.cleanOnBoot = true;

    loader = {
      systemd-boot = {
        enable = true;
        memtest86.enable = true;
      };

      efi.canTouchEfiVariables = true;
    };
  };
}
