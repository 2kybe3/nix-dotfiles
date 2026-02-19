{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ## Netowrking
    wget
    curl
    mtr

    cisco-packet-tracer_9
    element-desktop
    jetbrains.datagrip
    vesktop
    wireshark
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
    ranger
    unzip
    socat
    delta
    jdk21
    glow
    file
    tldr
    fzf
    dig
    git
    bat
    fd
    gh

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

    ## Games
    (prismlauncher.override {
      jdks = [
        jdk21
      ];
    })

    # Nixvim
    tree-sitter
    gcc

    home-manager
  ];
}
