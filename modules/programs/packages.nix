{ pkgs }:

with pkgs;
[
  ## Netowrking
  wget
  curl
  mtr

  ## Editors
  obsidian

  ## Apps
  vesktop
  element-desktop
  tor-browser
  spotify
  gimp

  ## CLI
  speedtest-cli
  ripgrep-all
  neofetch
  pamixer # pulseaudio command line mixer
  ripgrep
  openssl
  psmisc # killall etc.
  unzip
  delta
  tmux
  file
  sops
  fzf
  dig
  git
  bat
  fd
  gh

  ## TUI
  himalaya
  (btop.override {
    cudaSupport = true;
  })
  bottom
  ranger
  ncdu
  feh # Image Viewer

  ## Nix
  nixfmt-tree
  nix-index
  nixfmt
  nixd

  ## Bash
  shellcheck

  ## Rust
  jetbrains.datagrip
  rustup

  ## Games
  (prismlauncher.override {
    jdks = [
      jdk21
    ];
  })

  zsh
  jdk21
  pinentry-curses

  # Nixvim
  tree-sitter
  gcc
]
