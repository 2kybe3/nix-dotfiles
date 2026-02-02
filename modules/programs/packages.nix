{ pkgs }:
with pkgs;
[
  ## Netowrking
  wget
  curl
  mtr

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
  unrar
  delta
  file
  sops
  fzf
  dig
  git
  bat
  fd
  gh

  ## TUI
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

  jdk21
  pinentry-curses

  # Nixvim
  tree-sitter
  gcc
]
