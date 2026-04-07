{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lixPackageSets.latest.nixpkgs-review
    nix-output-monitor
    nix-prefetch-git
    attic-client
    nix-update
    upterm
  ];
}
