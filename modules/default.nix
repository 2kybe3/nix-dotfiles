{ ... }:
{

  imports = [
    ./lib

    ./virtualisation.nix
    ./networking.nix
    ./services.nix
    ./torrents.nix
    ./system.nix
    ./users.nix
    ./caddy.nix
    ./sway.nix
    ./boot.nix
    ./sops.nix
    ./programs
    ./nix.nix
  ];
}
