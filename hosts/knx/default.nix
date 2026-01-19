{ config, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix

    ../../modules
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
  ];

  i3.enable = true;
  firefox.enable = true;
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
      i3Enabled = config.i3.enable or false;
    };
    users.kybe = import ../../home/home.nix;
  };

  system.stateVersion = "25.11";
}
