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
    "${self}/modules/programs/zsh.nix"

    inputs.sops-nix.nixosModules.sops
  ];

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
      PermitEmptyPasswords = "yes";
    };
  };

  kybe.lib.hostName = "server";
  networking.hostId = "e2775ce5";
  users.users.root.shell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    vim
    git
  ];
  system.stateVersion = "25.05";
}
