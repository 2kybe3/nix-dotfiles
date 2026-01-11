{
  system,
  inputs,
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
    (inputs.nixpkgs-vesktop.legacyPackages.${system}.vesktop)
    element-desktop
    tor-browser
    spotify
    slack

    ## CLI
    speedtest-cli
    ripgrep-all
    fastfetch
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

    ## TUI
    himalaya # E-Mail client
    btop
    feh # Image Viewer
    lf

    ## Nix
    nixfmt-tree
    nixfmt
    nixd
    nix-index

    ## Bash
    shellcheck

    ## Rust
    jetbrains.rust-rover
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
