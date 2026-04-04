{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nix-prefetch-git
    nixpkgs-review
    attic-client
    nix-update
    upterm
  ];
}
