{ pkgs, ... }:

{
  networking.hostName = "knx";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

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

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;

  system.stateVersion = "25.11";
}
