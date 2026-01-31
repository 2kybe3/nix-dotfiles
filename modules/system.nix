{
  pkgs,
  ...
}:

{
  time.timeZone = "Europe/Berlin";

  hardware.bluetooth.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.departure-mono
  ];

  ##### Docker #####
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  ##### Boot loader #####
  boot.loader = {
    systemd-boot = {
      enable = true;
      memtest86.enable = true;
    };

    efi.canTouchEfiVariables = true;
  };
}
