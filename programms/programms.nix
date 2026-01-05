{ system, inputs, pkgs, ... }:
{
  imports = [
    ./firefox.nix
  ];

  # https://search.nixos.org/ https://mynixos.com/
  environment.systemPackages = with pkgs; [
    ## Netowrking
    wget
    curl
    mtr

    ## Editors
    vscodium
    vim

    ## Apps
    spotify
    (inputs.nixpkgs-vesktop.legacyPackages.${system}.vesktop)

    ## CLI
    speedtest-cli
    fastfetch
    pamixer
    psmisc
    unzip
    file

    ## TUI
    btop
    feh
    lf

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
    pinentry-tty
  ];

  programs.git.enable = true;
  programs.steam.enable = true;

  ##### ZSH #####
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      theme = "clean";
    };
  };

  ##### GPG Agent #####
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
