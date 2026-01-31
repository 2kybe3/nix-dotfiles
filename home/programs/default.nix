{ ... }:
{
  imports = [
    ./fd.nix
    ./zsh.nix
    ./git.nix
    ./ssh.nix
    ./tmux.nix
    ./btop.nix
    ./kitty.nix
    ./ranger.nix
  ];
  programs = {
    home-manager.enable = true;

    nixvim.imports = [ ./nixvim ];
  };
}
