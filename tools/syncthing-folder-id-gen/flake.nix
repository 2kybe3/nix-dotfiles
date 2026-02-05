{
  description = "Generate random syncthing folder id (tho it doesn't have to follow this format)";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};

    pkg = pkgs.writeShellApplication {
      name = "syncthing-folder-id-gen";
      runtimeInputs = [
        pkgs.openssl
        pkgs.coreutils
      ];
      text = ''
        openssl rand 10 \
          | base32 \
          | tr 'A-Z2-7' 'a-z2-7' \
          | cut -c1-10 \
          | sed 's/.\{5\}/&-/'
      '';
    };
  in {
    apps.${system}.default = {
      type = "app";
      program = "${pkg}/bin/syncthing-folder-id-gen";
    };
  };
}
