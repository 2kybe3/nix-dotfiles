{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ## Netowrking
    wget
    curl
    mtr

    ## Apps
    jetbrains.datagrip
    element-desktop
    tor-browser
    wireshark
    vesktop
    spotify
    gimp

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
    delta
    file
    glow
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
    ranger
    ncdu
    feh # Image Viewer

    ## Nix
    statix
    nixd

    ## Bash
    shellcheck

    ## Games
    (prismlauncher.override {
      jdks = [
        jdk21
      ];
    })

    jdk21

    # Nixvim
    tree-sitter
    gcc
  ];
}
