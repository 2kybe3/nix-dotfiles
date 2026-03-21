{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nixpkgs-review
    attic-server
    nix-update
  ];
}
