{
  lib,
  config,
  pkgs,
  ...
}:

{
  time.timeZone = "Europe/Berlin";

  sops = import ./sops.nix;
  services = import ./services.nix { inherit lib; };
  users = import ./users.nix { inherit pkgs config; };

  hardware.bluetooth.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.departure-mono
  ];

  ##### Docker #####
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  ##### Nix Settings #####
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  ##### Boot loader #####
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}
