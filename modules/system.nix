{
  lib,
  config,
  pkgs,
  ...
}:

{
  time.timeZone = "Europe/Berlin";

  hardware.bluetooth.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.departure-mono
  ];

  ##### Docker #####
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  ##### TTY #####
  services.getty = {
    autologinOnce = true;
    autologinUser = "kybe";
    helpLine = lib.mkForce "";
  };

  ##### Kwallet #####
  programs.kdeconnect.enable = true;
  security.pam.services.login.kwallet = {
    enable = true;
    package = pkgs.kdePackages.kwallet-pam;
  };
  environment.systemPackages = with pkgs; [
    kdePackages.kwallet
    kdePackages.kwallet-pam
    kdePackages.kwalletmanager
  ];

  #### Sops #####
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/nix/persist/var/lib/sops-nix/key.txt";

    secrets.kybe-imap = {
      owner = "kybe";
    };

    secrets.root-pass = { };
    secrets.root-pass.neededForUsers = true;
    secrets.kybe-pass = { };
    secrets.kybe-pass.neededForUsers = true;
  };

  ##### Users #####
  users = {
    mutableUsers = false;
    users.root = {
      hashedPasswordFile = config.sops.secrets.root-pass.path;
    };

    users.kybe = {
      isNormalUser = true;
      description = "2kybe3";
      shell = pkgs.zsh;
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM7irWuDZwx7ZvPSiUwBbxUxKL/7aMQmy/8oxput1bID kybe@khost"
      ];
      hashedPasswordFile = config.sops.secrets.kybe-pass.path;
    };
  };

  ##### Nix Settings #####
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  ##### Boot loader #####
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  ##### Services #####
  services = {
    dbus.enable = true;
    printing.enable = true;
    mullvad-vpn.enable = true;

    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    openssh = {
      enable = true;
      ports = [
        22
      ];
      settings = {
        PasswordAuthentication = true;
        AllowUsers = [ "kybe" ];
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "no";
      };
    };
  };
}
