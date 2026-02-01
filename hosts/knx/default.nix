{ config, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix

    ../../modules/lib
    ../../modules/nix.nix
    ../../modules/sops.nix
    ../../modules/sway.nix
    ../../modules/boot.nix
    ../../modules/programs
    ../../modules/caddy.nix
    ../../modules/users.nix
    ../../modules/networking
    ../../modules/system.nix
    ../../modules/services.nix
    ../../modules/syncthing.nix
    ../../modules/virtualisation.nix
    ../../modules/networking/kybe-vpn.nix
    ../../modules/networking/networkmanager.nix

    inputs.sops-nix.nixosModules.sops
  ];

  sway.enable = true;

  kybe.lib.hostName = "knx";
  networking.hostName = config.kybe.lib.hostName;

  system.stateVersion = "25.11";
}
