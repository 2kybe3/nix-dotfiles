{ ... }:
{
  imports = [
    ./networking.nix
    ./services.nix
    ./system.nix
    ./users.nix
    ./caddy.nix
    ./sway.nix
    ./sops.nix
    ./programs
    ./nix.nix
  ];
}
