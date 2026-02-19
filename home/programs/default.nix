{
  lib,
  self,
  pkgs,
  system,
  config,
  ...
}: {
  imports = lib.flatten [
    ./sway
    ./fd.nix
    ./mpv.nix
    ./zsh.nix
    ./git.nix
    ./ssh.nix
    ./tmux.nix
    ./rmpc.nix
    ./btop.nix
    ./kitty.nix
    ./yt-dlp.nix
    ./ranger.nix
    ./keepass.nix
    ./obsidian.nix
  ];
  home.packages = with pkgs; [
    cisco-packet-tracer_9

    ## Apps
    jetbrains.datagrip
    element-desktop
    wireshark
    vesktop
    spotify
    gimp

    delta
    glow
    gh

    ranger

    ## Games
    (prismlauncher.override {
      jdks = [
        jdk21
      ];
    })
  ];
  programs = {
    home-manager.enable = true;

    nixvim = {
      imports = [./nixvim];
      _module.args = {
        inherit self system;
        home = config.home;
      };
    };
  };
}
