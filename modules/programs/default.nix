{
  pkgs,
  cheat-sh,
  ...
}: {
  imports = [
    ./zsh.nix
    ./obs.nix
    ./gnupg.nix
    ./firefox.nix
  ];
  environment.systemPackages =
    import ./packages.nix {inherit pkgs;}
    ++ [
      cheat-sh
    ];
  programs = {
    steam.enable = true;
    zoxide.enable = true;
    wireshark.enable = true;
    fzf.fuzzyCompletion = true;
  };
}
