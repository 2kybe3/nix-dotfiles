{
  lib,
  pkgs,
  config,
  ...
}:
{
  specialisation."stable-kernel".configuration.boot.kernelPackages = lib.mkForce pkgs.linuxPackages;
  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxKernel.packages.linux_testing;
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
