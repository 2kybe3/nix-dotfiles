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
    "${self}/modules/tor.nix"
    "${self}/modules/ssh.nix"
    "${self}/modules/sops.nix"
    "${self}/modules/sops.nix"
    "${self}/modules/sway.nix"
    "${self}/modules/boot.nix"
    "${self}/modules/programs"
    "${self}/modules/caddy.nix"
    "${self}/modules/users.nix"
    "${self}/modules/getty.nix"
    "${self}/modules/networking"
    "${self}/modules/system.nix"
    "${self}/modules/printer.nix"
    "${self}/modules/pipewire.nix"
    "${self}/modules/services.nix"
    "${self}/modules/journald.nix"
    "${self}/modules/syncthing.nix"
    "${self}/modules/virtualisation.nix"
    "${self}/modules/networking/kybe-vpn.nix"
    "${self}/modules/networking/networkmanager.nix"

    "${self}/containers/i2pd.nix"

    inputs.sops-nix.nixosModules.sops
    inputs.nix-index-database.nixosModules.default
  ];

  kybe.lib.hostName = "knx";
  networking.hostName = config.kybe.lib.hostName;

  system.stateVersion = "25.11";
}
