{
  pkgs,
  cpkgs,
  ...
}:
{
  imports = [
    ./sway
    ./fd.nix
    ./mpv.nix
    ./git.nix
    ./ssh.nix
    ./iamb.nix
    ./yazi.nix
    ./fish.nix
    ./tmux.nix
    ./rmpc.nix
    ./btop.nix
    ./kitty.nix
    ./yt-dlp.nix
    ./ranger.nix
    ./keepass.nix
    ./managarr.nix
    ./obsidian.nix
    ./packages.nix
    ./librewolf.nix
  ];

  home.packages = [
    pkgs.tree-sitter
    cpkgs.kyvim
  ];
  programs.home-manager.enable = true;
}
