{
  self,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./proxmox.nix

    "${self}/modules/lib"
    "${self}/modules/arr.nix"
    "${self}/modules/nix.nix"
    "${self}/modules/sops.nix"
    "${self}/modules/caddy.nix"
    "${self}/modules/monitoring"
    "${self}/modules/networking"
    "${self}/modules/torrents.nix"
    "${self}/modules/journald.nix"
    "${self}/modules/syncthing.nix"

    inputs.sops-nix.nixosModules.sops
  ];

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = false;
    };
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM7irWuDZwx7ZvPSiUwBbxUxKL/7aMQmy/8oxput1bID kybe@knx"
  ];

  kybe.lib.hostName = "server";
  networking.hostId = "e2775ce5";
  users.users.root.shell = pkgs.bash;

  environment.systemPackages = with pkgs; [
    vim
    git
  ];
  system.stateVersion = "25.05";
}
