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

    # TOOLS
    rust-dev = {
      url = "path:./tools/rust-dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    screenshot-sway-zipline = {
      url = "path:./tools/screenshot-sway-zipline";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cheat-sh = {
      url = "path:./tools/cheat-sh";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    rust-dev,
    cheat-sh,
    screenshot-sway-zipline,
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

    makeSystem = hostModule:
      nixpkgs.lib.nixosSystem {
        inherit system pkgs;

        specialArgs = {
          inherit self inputs system;
          screenshot-sway-zipline = screenshot-sway-zipline.packages.${system}.default;
          cheat-sh = cheat-sh.packages.${system}.default;
        };

        modules = [hostModule];
      };
  in {
    nixosConfigurations = {
      knx = makeSystem ./hosts/knx;
      server = makeSystem ./hosts/server;
    };

    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
    devShells.${system}.rust = rust-dev.devShells.${system}.default;
  };
}
