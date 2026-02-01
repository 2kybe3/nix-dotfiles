{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./proxmox.nix

    ../../modules/lib
    ../../modules/arr.nix
    ../../modules/nix.nix
    ../../modules/sops.nix
    ../../modules/caddy.nix
    ../../modules/networking
    ../../modules/torrents.nix
    ../../modules/syncthing.nix
    ../../modules/programs/zsh.nix

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

  networking = {
    hostId = "e2775ce5";
  };

  users.users.root = {
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    vim
    git
  ];
  system.stateVersion = "25.05";
}
