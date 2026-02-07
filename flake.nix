{
  description = "Kybe's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-dev = {
      url = "path:./tools/rust-dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    rust-dev,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        nvidia.acceptLicense = true;
      };
    };
  in {
    nixosConfigurations = {
      server = nixpkgs.lib.nixosSystem {
        inherit system pkgs;

        specialArgs = {
          inherit inputs system;
        };

        modules = [
          ./hosts/server
        ];
      };
      knx = nixpkgs.lib.nixosSystem {
        inherit system pkgs;

        specialArgs = {
          inherit inputs system;
        };

        modules = [
          ./hosts/knx
        ];
      };
    };

    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
    devShells.${system}.rust = rust-dev.devShells.${system}.default;
  };
}
