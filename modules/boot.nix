{
  lib,
  pkgs,
  ...
}:
{
  boot = {
    kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_7_0;
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
