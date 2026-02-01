{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./proxmox.nix

    ../../modules/lib
    ../../modules/nix.nix
    ../../modules/sops.nix
    ../../modules/caddy.nix
    ../../modules/torrents.nix
    ../../modules/syncthing.nix
    ../../modules/programs/zsh.nix
    ../../modules/networking

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

  networking = {
    hostId = "e2775ce5";
  };
  kybe.lib.hostName = "server";

  users.users.root = {
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    vim
    git
  ];
  system.stateVersion = "25.05";
}
