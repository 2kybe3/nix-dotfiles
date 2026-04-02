{
  description = "Kybe's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-mpscribble.url = "github:nixos/nixpkgs/?ref=pull/502095/head";
    master-nixpkgs.url = "github:nixos/nixpkgs/master";

    gh-notify-daemon = {
      url = "git+https://git.kybe.xyz/2kybe3/gh-notify-daemon";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    # TOOL
    rust-dev = {
      url = "path:./tools/rust-dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    screenshot-sway-zipline = {
      url = "path:./tools/screenshot-sway-zipline";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cheat-sh = {
      url = "github:2kybe3/cheat-sh";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    rust-dev,
    cheat-sh,
    home-manager,
    master-nixpkgs,
    nixpkgs-mpscribble,
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
    master = import master-nixpkgs {
      inherit system;
    };
    mpdscribble = import nixpkgs-mpscribble {
      inherit system;
    };

    cpkgs = {
      screenshot-sway-zipline = screenshot-sway-zipline.packages.${system}.default;
      cheat-sh = cheat-sh.packages.${system}.default;
    };

    makeSystem = hostModule:
      nixpkgs.lib.nixosSystem {
        inherit system pkgs;

        specialArgs = {
          inherit self inputs system cpkgs master;
        };

        modules = [
          hostModule
        ];
      };
  in {
    nixosConfigurations = {
      knx = makeSystem ./hosts/knx;
    };
    homeConfigurations."kybe" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      extraSpecialArgs = {
        inherit self inputs system cpkgs mpdscribble;
      };

      modules = [
        inputs.nixvim.homeModules.nixvim
        inputs.sops-nix.homeManagerModules.sops
        inputs.gh-notify-daemon.homeManagerModules.gh-notify-daemon
        ./home
      ];
    };

    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
    devShells.${system}.rust = rust-dev.devShells.${system}.default;
  };
}
