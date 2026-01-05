{ pkgs, ... }:

{
  networking.hostName = "knx";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  networking.firewall.allowedTCPPorts = [ 22 ];

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  hardware.bluetooth.enable = true;

  ##### Users #####
  users.users.kybe = {
    isNormalUser = true;
    extraGroups = [ 
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM7irWuDZwx7ZvPSiUwBbxUxKL/7aMQmy/8oxput1bID kybe@khost"
    ];
  };

  ##### Nix Settings #####
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ##### Boot loader #####
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ##### Services #####

  services.printing.enable = true;
  services.mullvad-vpn.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
    dnsovertls = "true";
  };

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "kybe" ];
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "yes";
    };
  };

  system.stateVersion = "25.11";
}
