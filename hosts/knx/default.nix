{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix

    ../../lib
    ../../programs
    ../../boot.nix
    ../../caddy.nix
    ../../networking.nix
    ../../nix.nix
    ../../services.nix
    ../../sops.nix
    ../../sway.nix
    ../../system.nix
    ../../users.nix
    ../../virtualisation.nix

    inputs.sops-nix.nixosModules.sops
  ];

  sway.enable = true;

  networking.hostName = "knx";

  system.stateVersion = "25.11";
}
