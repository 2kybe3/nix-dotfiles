{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ lixPackageSets.latest.lix ];
  nix = {
    package = pkgs.lixPackageSets.latest.lix;
    settings = {
      substituters = [
        "https://attic.kybe.xyz/main"
      ];
      trusted-substituters = [
        "https://attic.kybe.xyz/main"
      ];
      trusted-public-keys = [
        "main:cb7V485kGP0lG7LtQ/suOgKOgtVxNXrnD6i5yCtnaMQ="
      ];
      auto-optimise-store = true;
      trusted-users = [
        "root"
        "@wheel"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "20:00";
    };
  };
}
