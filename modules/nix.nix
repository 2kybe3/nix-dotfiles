{
  nix = {
    settings = {
      auto-optimise-store = true;
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
