{
  self,
  config,
  inputs,
  ...
}:
let
  modules = [
    "nix"
    "tor"
    "ssh"
    "virt"
    "sops"
    "sway"
    "boot"
    "caddy"
    "users"
    "getty"
    "docker"
    "system"
    "printer"
    "pipewire"
    "services"
    "journald"
    "syncthing"
  ]
  ++ [
    "lib"
    "programs"
    "networking"
    "networking/vpn"
    "networking/networkmanager"
  ];

  moduleImports = map (
    m:
    let
      path = "${self}/modules/${m}";
    in
    if builtins.pathExists (path + ".nix") then path + ".nix" else path
  ) modules;
in
{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix

    inputs.sops-nix.nixosModules.sops
  ]
  ++ moduleImports;

  kybe.lib.hostName = "knx";
  networking.hostName = config.kybe.lib.hostName;

  system.stateVersion = "25.11";
}
