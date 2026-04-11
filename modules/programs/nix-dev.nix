{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lixPackageSets.latest.nix-fast-build
    lixPackageSets.latest.nixpkgs-review
    lixPackageSets.latest.nix-update
    nix-output-monitor
    nix-prefetch-git
    attic-client
    upterm
  ];
}
