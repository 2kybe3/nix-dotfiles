{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nixpkgs-review
    nix-update
  ];
}
