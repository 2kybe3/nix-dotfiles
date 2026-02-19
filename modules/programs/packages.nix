{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ## Netowrking
    wget
    curl
    mtr

    ## CLI
    speedtest-cli
    ripgrep-all
    neofetch
    pamixer # pulseaudio command line mixer
    ripgrep
    openssl
    ffmpeg
    psmisc # killall etc.
    unzip
    socat
    file
    tldr
    fzf
    dig
    git
    bat
    fd

    ## TUI
    vim
    (btop.override {
      cudaSupport = true;
    })
    ncdu
    feh # Image Viewer

    ## Nix
    statix
    nixd

    ## Bash
    shellcheck

    jdk21

    # Nixvim
    tree-sitter
    gcc

    home-manager
  ];
}
