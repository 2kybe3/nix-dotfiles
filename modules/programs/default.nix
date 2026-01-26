{ pkgs, ... }:
{
  environment.systemPackages = import ./packages.nix { inherit pkgs; };
  programs = {
    steam.enable = true;
    zoxide.enable = true;
    fzf.fuzzyCompletion = true;

    zsh = import ./zsh.nix;
    firefox = import ./firefox.nix;
    gnupg = import ./gnupg.nix { inherit pkgs; };
    obs-studio = import ./obs.nix { inherit pkgs; };
  };
}
