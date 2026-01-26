{ config, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix

    ../../modules
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
  ];

  sway.enable = true;

  networking.hostName = "knx";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [
      inputs.nixvim.homeModules.nixvim
    ];
    extraSpecialArgs = {
      swayEnabled = config.sway.enable or false;
    };
    users.kybe = import ../../home/home.nix;
  };

  system.stateVersion = "25.11";
}
