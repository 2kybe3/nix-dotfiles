{cpkgs, ...}: {
  imports = [
    ./zsh.nix
    ./obs.nix
    ./gnupg.nix
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
    wireshark.enable = true;
    fzf.fuzzyCompletion = true;
  };
}
