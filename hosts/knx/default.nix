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
  hyprland.enable = false;

  networking.hostName = "knx";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [
      inputs.nixvim.homeModules.nixvim
    ];
    extraSpecialArgs = {
      hyprlandEnabled = config.hyprland.enable or false;
      swayEnabled = config.sway.enable or false;
    };
    users.kybe = import ../../home/home.nix;
  };

  system.stateVersion = "25.11";
}
