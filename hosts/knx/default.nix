{ config, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix

    ../../modules
    inputs.sops-nix.nixosModules.sops
  ];

  sway.enable = true;

  networking.hostName = "knx";

  system.stateVersion = "25.11";
}
