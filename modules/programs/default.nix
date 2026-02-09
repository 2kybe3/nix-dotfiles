{
  pkgs,
  cheat-sh,
  ...
}: {
  imports = [
    ./firefox.nix
    ./zsh.nix
    ./gnupg.nix
    ./obs.nix
  ];
  environment.systemPackages =
    import ./packages.nix {inherit pkgs;}
    ++ [
      cheat-sh
    ];
  programs = {
    steam.enable = true;
    zoxide.enable = true;
    fzf.fuzzyCompletion = true;
  };
}
