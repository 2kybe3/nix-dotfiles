{
  projectRootFile = "flake.nix";
  programs = {
    taplo.enable = true;
    typos.enable = true;
    nixfmt.enable = true;
  };
  settings = {
    excludes = [
      "home/config/amoled-cord.theme.css"
      "secrets/*"
      "result/*"
      ".git/*"
    ];
  };
}
