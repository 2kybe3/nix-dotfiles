{ pkgs, ... }:
{
  imports = [
    ./firefox.nix
  ];

  # https://search.nixos.org/ https://mynixos.com/
  environment.systemPackages = with pkgs; [
    vim
    wget
    mtr
    curl
    zsh
    kitty
    vscodium
    vesktop
    pamixer
    spotify
    jetbrains.rust-rover
    btop
    feh
    fastfetch
    unzip
    psmisc
    lf
    jdk21
    rustup
    sccache
    speedtest-cli
    neovim
    file
    nixfmt
    nixd
    (prismlauncher.override {
      jdks = [
        jdk21
      ];
    })
  ];

  programs.git.enable = true;

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
