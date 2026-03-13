{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    playerctl

    ## Netowrking
    traceroute
    tcpdump
    dig
    wget
    curl
    mtr

    jetbrains.datagrip
    element-desktop
    wireshark
    vesktop
    gimp

    gparted

    ## CLI
    speedtest-cli
    ripgrep-all
    cifs-utils
    fastfetch
    pamixer # pulseaudio command line mixer
    ripgrep
    openssl
    ffmpeg
    psmisc # killall etc.
    ranger
    unzip
    socat
    p7zip
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
    (btop.override {
      cudaSupport = true;
    })
    vim
    weechat
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

    jetbrains.idea
    recaf-launcher

    # Nixvim
    tree-sitter
    gcc

    home-manager
  ];
}
