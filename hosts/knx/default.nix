{
  self,
  config,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix

    "${self}/modules/lib"
    "${self}/modules/nix.nix"
    "${self}/modules/sops.nix"
    "${self}/modules/sway.nix"
    "${self}/modules/boot.nix"
    "${self}/modules/programs"
    "${self}/modules/caddy.nix"
    "${self}/modules/users.nix"
    "${self}/modules/networking"
    "${self}/modules/system.nix"
    "${self}/modules/services.nix"
    "${self}/modules/syncthing.nix"
    "${self}/modules/journal-clear.nix"
    "${self}/modules/virtualisation.nix"
    "${self}/modules/networking/kybe-vpn.nix"
    "${self}/modules/networking/networkmanager.nix"

    inputs.sops-nix.nixosModules.sops
    inputs.nix-index-database.nixosModules.default
  ];

  kybe.lib.hostName = "knx";
  networking.hostName = config.kybe.lib.hostName;

  system.stateVersion = "25.11";
}
