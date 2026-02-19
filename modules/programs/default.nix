{cpkgs, ...}: {
  imports = [
    ./zsh.nix
    ./obs.nix
    ./gnupg.nix
    ./firefox.nix
    ./packages.nix
    ./firejail.nix
    ./libreoffice.nix
    ./cisco-packet-tracer.nix
  ];
  environment.systemPackages = [
    cpkgs.cheat-sh
  ];
  programs = {
    steam.enable = true;
    zoxide.enable = true;
    firefox.enable = true;
    wireshark.enable = true;
    fzf.fuzzyCompletion = true;
  };
}
