{pkgs, ...}: let
  serverSSH = "root@10.0.5.6";
  nixosConfigPath = "~/.dotfiles";
in {
  programs.fish = {
    enable = true;
    interactiveShellInit = builtins.readFile ../config/fish.fish;
    shellAliases = {
      cd = "z";
      ls = "${pkgs.eza}/bin/eza -al";
      tm = "tmux new-session -A -s main";

      # SSH stuff
      server = "ssh ip.kybe.xyz";

      # NIX stuff
      flake-update = "nix flake update --flake .";
      collect-garbage = "sudo nix-collect-garbage -d; nix-collect-garbage -d";
      knx-full = "knx-build; knx-hm";
      knx-build = "sudo nixos-rebuild switch --flake ${nixosConfigPath}#knx --upgrade";
      knx-hm = "home-manager switch --flake ${nixosConfigPath} --show-trace";
      server-build = "sudo SSH_AUTH_SOCK=$SSH_AUTH_SOCK nixos-rebuild switch --flake ${nixosConfigPath}#server --target-host ${serverSSH}";
    };
  };
}
