let
  nixosConfigPath = "~/.dotfiles";
in {
  programs.fish = {
    enable = true;
    interactiveShellInit = builtins.readFile ../config/fish.fish;
    shellAliases = {
      tm = "tmux attach || tmux new";
      os-update = "nix flake update --flake ${nixosConfigPath}; sudo nixos-rebuild switch --flake ${nixosConfigPath}#knx --upgrade; home-manager switch --flake ${nixosConfigPath} --show-trace";
    };
  };
}
