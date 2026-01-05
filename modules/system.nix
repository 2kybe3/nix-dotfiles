{ pkgs, ... }:

{
  networking.hostName = "knx";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];

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

  system.stateVersion = "25.11";
}
