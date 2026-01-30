{ ... }:
{
  imports = [
    ./fd.nix
    ./zsh.nix
    ./git.nix
    ./tmux.nix
    ./btop.nix
    ./ranger.nix
  ];
  programs = {
    home-manager.enable = true;

    nixvim.imports = [ ./nixvim ];
  };
}
