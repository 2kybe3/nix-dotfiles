{ config, lib, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "knx";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ##############
  ## Services ##
  ##############

  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;

  ###############
  ## Programms ##
  ###############

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
    hyprpicker
    tofi
    feh
    hyprpolkitagent
    hyprcursor
    fastfetch
    unzip
    hyprsysteminfo
    hyprpaper
    psmisc
    lf
    ashell
    hyprshot
    jdk21
    rustup
    sccache
    speedtest-cli
    neovim
    dunst
    wl-clipboard-rs
    (prismlauncher.override {
      jdks = [
        jdk21
      ];
    })
  ];

  programs.git.enable = true;
  programs.hyprland.enable = true;

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      theme = "clean";
    };
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system.stateVersion = "25.11";
}
