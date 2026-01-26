{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    ## Netowrking
    wget
    curl
    mtr # traceroute + ping tool

    ## Editors
    vscodium
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
    fastfetch
    pamixer # pulseaudio command line mixer
    ripgrep
    openssl
    psmisc # killall etc.
    unzip
    delta # git diff viewer
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
    himalaya # E-Mail client
    (btop.override {
      cudaSupport = true;
    })
    bottom
    ncdu
    feh # Image Viewer
    lf # file browser

    ## Nix
    nixfmt-tree
    nixfmt
    nixd
    nix-index

    ## Bash
    shellcheck

    ## Rust
    jetbrains.rust-rover
    jetbrains.datagrip
    rustup
    mdbook

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
  ];

  programs = {
    steam.enable = true;
    zoxide.enable = true;

    fzf.fuzzyCompletion = true;

    ##### GPG Agent #####
    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
      enableSSHSupport = true;
    };
  };
}
