{
  description = "Kybe's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    gh-notify-daemon = {
      url = "git+https://git.kybe.xyz/2kybe3/gh-notify-daemon";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cheat-sh = {
      url = "github:2kybe3/cheat-sh";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      cheat-sh,
      flake-utils,
      treefmt-nix,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = import ./overlays;
        config = {
          allowUnfreePredicate =
            pkg:
            builtins.elem (nixpkgs.lib.getName pkg) [
              "nvidia-settings"
              "nvidia-x11"

              "steam-unwrapped"
              "steam"

              "obsidian"

              "datagrip"
              "idea"
            ];
          nvidia.acceptLicense = true;
        };
      };

      cpkgs = {
        git-local-only = import ./random-scripts/git-local-only { inherit pkgs; };
        home-manager = home-manager.packages.${system}.default;
        cheat-sh = cheat-sh.packages.${system}.default;
      };
    in
    {
      homeConfigurations."kybe" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit
            self
            cpkgs
            inputs
            system
            ;
        };

        modules = [
          inputs.nixvim.homeModules.nixvim
          inputs.sops-nix.homeManagerModules.sops
          inputs.gh-notify-daemon.homeManagerModules.gh-notify-daemon
          ./home
        ];
      };
      nixosConfigurations.knx = nixpkgs.lib.nixosSystem {
        inherit system pkgs;

        specialArgs = {
          inherit
            self
            cpkgs
            system
            inputs
            ;
        };

        modules = [
          ./hosts/knx
        ];
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        treefmt-eval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
      in
      {
        checks.formatting = treefmt-eval.config.build.check self;
        formatter = treefmt-eval.config.build.wrapper;
      }
    );
}
