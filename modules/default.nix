{ ... }:
{
  imports = [
    ./networking.nix
    ./services.nix
    ./system.nix
    ./users.nix
    ./sway.nix
    ./sops.nix
    ./programs
    ./nix.nix
  ];
}
