{
  description = "Screenshot tool for sway with zipline upload";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
        name = "screenshot-sway-zipline";
        deps = [
          pkgs.jq
          pkgs.curl
          pkgs.grim
          pkgs.slurp
          pkgs.coreutils
          pkgs.wl-clipboard-rs
        ];
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = name;
          version = "1.0.0";
          src = ./.;

          nativeBuildInputs = [pkgs.makeWrapper];
          buildInputs = deps;

          installPhase = ''
            mkdir -p $out/bin
            install -m755 ${./script.sh} $out/bin/${name}

            wrapProgram $out/bin/${name} --set PATH "${pkgs.lib.makeBinPath deps}"
          '';
        };

        apps.default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/${name}";
        };
      }
    );
}
