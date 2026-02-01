{ ... }:
{
  imports = [
    ./virtualisation.nix
    ./networking.nix
    ./services.nix
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
