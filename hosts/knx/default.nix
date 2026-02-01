{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix

    ../../modules/lib
    ../../modules/programs
    ../../modules/boot.nix
    ../../modules/caddy.nix
    ../../modules/networking.nix
    ../../modules/nix.nix
    ../../modules/services.nix
    ../../modules/sops.nix
    ../../modules/sway.nix
    ../../modules/system.nix
    ../../modules/users.nix
    ../../modules/virtualisation.nix

    inputs.sops-nix.nixosModules.sops
  ];

  sway.enable = true;

  networking.hostName = "knx";

  system.stateVersion = "25.11";
}
