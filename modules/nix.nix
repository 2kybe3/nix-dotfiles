{
  nix = {
    settings = {
      substituters = [
        "https://attic.kybe.xyz/main"
        "https://attic.kybe.xyz/kystash"
        "https://attic.kybe.xyz/nixpkgs-review-gha"
      ];
      trusted-substituters = [
        "https://attic.kybe.xyz/main"
        "https://attic.kybe.xyz/kystash"
        "https://attic.kybe.xyz/nixpkgs-review-gha"
      ];
      trusted-public-keys = [
        "main:cb7V485kGP0lG7LtQ/suOgKOgtVxNXrnD6i5yCtnaMQ="
        "kystash:/MkDQAdFay9AibvNmmZUhDLUnHhUTcwnp7hPX0afRH0="
        "nixpkgs-review-gha:HihD+g09Q285kmlfIticfykHnAyp3FqMqjOk3d1Qi6o="
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
