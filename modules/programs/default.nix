{cpkgs, ...}: {
  imports = [
    ./zsh.nix
    ./obs.nix
    ./gnupg.nix
    ./firefox.nix
    ./packages.nix
    ./libreoffice.nix
  ];
  environment.systemPackages = [
    cpkgs.cheat-sh
  ];
  programs = {
    steam.enable = true;
    zoxide.enable = true;
    wireshark.enable = true;
    fzf.fuzzyCompletion = true;
  };
}
