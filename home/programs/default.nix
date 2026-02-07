{
  lib,
  swayEnabled,
  ...
}: {
  imports = lib.flatten [
    ./fd.nix
    ./zsh.nix
    ./git.nix
    ./ssh.nix
    ./tmux.nix
    ./btop.nix
    ./kitty.nix
    ./ranger.nix
    ./keepass.nix
    (lib.optional swayEnabled ./sway)
  ];
  programs = {
    home-manager.enable = true;

    nixvim.imports = [./nixvim];
  };
}
