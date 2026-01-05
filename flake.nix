{
  description = "Kybe's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/pull/476347/head";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixvim,
      ...
    }:
    {
      nixosConfigurations.knx = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./programms/programms.nix
          ./modules/system.nix
          ./modules/hyprland.nix
          ./hardware/hardware-configuration.nix
          ./hardware/nvidia.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [
              nixvim.homeModules.nixvim
            ];
            home-manager.users.kybe = ./home/home.nix;
          }
        ];
      };
    };
}
