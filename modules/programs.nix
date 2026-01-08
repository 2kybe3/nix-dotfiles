{ system, inputs, pkgs, ... }:
{
  # https://search.nixos.org/ https://mynixos.com/
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
    ripgrep-all # ripgrep with extra files
    fastfetch
    pamixer # pulseaudio command line mixer
    ripgrep # Fast file search
    openssl # Provides some usefull stuff (openssl rand -hex <length>, etc.)
    psmisc # killall etc.
    unzip
    file
    sops # secrets
    fzf # fuzzy find
    dig
    git
    bat # cat
    fd # find replacement

    ## TUI
    btop
    feh # iamge viewer
    lf # file browser

    ## Nix
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

  programs.zoxide.enable = true;
  programs.steam.enable = true;
 
  ##### GPG Agent #####
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableSSHSupport = true;
  };
}
