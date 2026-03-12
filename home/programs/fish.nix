{pkgs, ...}: let
  nixosConfigPath = "~/.dotfiles";
in {
  programs.fish = {
    enable = true;
    interactiveShellInit = builtins.readFile ../config/fish.fish;
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza -al";
      tm = "tmux attach || tmux new";
      os-update = "nix flake update --flake ${nixosConfigPath}; sudo nixos-rebuild switch --flake ${nixosConfigPath}#knx --upgrade; home-manager switch --flake ${nixosConfigPath} --show-trace";
    };
  };
}
