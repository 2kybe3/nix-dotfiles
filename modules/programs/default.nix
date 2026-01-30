{ pkgs, ... }:
{
  imports = [
    ./firefox.nix
    ./zsh.nix
    ./gnupg.nix
    ./obs.nix
  ];
  environment.systemPackages = import ./packages.nix { inherit pkgs; };
  programs = {
    steam.enable = true;
    zoxide.enable = true;
    fzf.fuzzyCompletion = true;
  };
}
