{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix

    ../../modules/torrents.nix

    ../../modules/lib
    ../../modules/nix.nix
    ../../modules/sops.nix
    ../../modules/sway.nix
    ../../modules/boot.nix
    ../../modules/programs
    ../../modules/caddy.nix
    ../../modules/users.nix
    ../../modules/system.nix
    ../../modules/services.nix
    ../../modules/syncthing.nix
    ../../modules/networking
    ../../modules/networking/networkmanager.nix
    ../../modules/networking/kybe-vpn.nix
    ../../modules/virtualisation.nix

    inputs.sops-nix.nixosModules.sops
  ];

  sway.enable = true;

  networking.hostName = "knx";

  system.stateVersion = "25.11";
}
