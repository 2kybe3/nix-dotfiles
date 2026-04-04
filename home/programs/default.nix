{
  lib,
  self,
  pkgs,
  config,
  system,
  ...
}:
{
  imports = lib.flatten [
    ./sway
    ./fd.nix
    ./mpv.nix
    ./git.nix
    ./ssh.nix
    ./fish.nix
    ./tmux.nix
    ./rmpc.nix
    ./btop.nix
    ./kitty.nix
    ./yt-dlp.nix
    ./ranger.nix
    ./keepass.nix
    ./obsidian.nix
    ./librewolf.nix
  ];

  home.packages = with pkgs; [
    tree-sitter
  ];
  programs = {
    home-manager.enable = true;

    nixvim = {
      imports = [ ./nixvim ];
      _module.args = {
        inherit self system;
        inherit (config) home;
      };
    };
  };
}
