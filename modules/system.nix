{
  lib,
  config,
  pkgs,
  ...
}:

{
  time.timeZone = "Europe/Berlin";

  sops = import ./sops.nix;

  hardware.bluetooth.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.departure-mono
  ];

  ##### Docker #####
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  ##### Users #####
  users = {
    defaultUserShell = pkgs.zsh;
    mutableUsers = false;
    users.root = {
      hashedPasswordFile = config.sops.secrets.root-pass.path;
    };

    users.kybe = {
      isNormalUser = true;
      description = "2kybe3";
      shell = pkgs.zsh;
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM7irWuDZwx7ZvPSiUwBbxUxKL/7aMQmy/8oxput1bID kybe@khost"
      ];
      hashedPasswordFile = config.sops.secrets.kybe-pass.path;
    };
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

  ##### Services #####
  services = import ./services.nix { inherit lib; };
}
