{ cpkgs, ... }:
{
  imports = [
    ./obs.nix
    ./gnupg.nix
    ./packages.nix
    ./libreoffice.nix
    ./nix-dev.nix
  ];
  environment.systemPackages = [
    cpkgs.cheat-sh
  ];
  programs = {
    fish.enable = true;
    steam.enable = true;
    zoxide.enable = true;
    wireshark.enable = true;
    fzf.fuzzyCompletion = true;
  };
}
