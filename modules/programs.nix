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

    ## Apps
    spotify
    tor-browser
    element-desktop
    (inputs.nixpkgs-vesktop.legacyPackages.${system}.vesktop)

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
    file
    sops
    fzf # fuzzy find
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

    ## Rust
    jetbrains.rust-rover
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
  ];

  programs.steam.enable = true;
  programs.zoxide.enable = true;

  ##### GPG Agent #####
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableSSHSupport = true;
  };
}
