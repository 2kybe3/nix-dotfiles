{ pkgs, config }:
{
  home-manager.enable = true;
  nixvim.imports = [ ./nixvim ];

  fd = import ./fd.nix;
  git = import ./git.nix;
  tmux = import ./tmux.nix;
  btop = import ./btop.nix;
  zsh = import ./zsh.nix { inherit pkgs config; };
}
