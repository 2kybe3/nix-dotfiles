{ lib, inputs, pkgs, ... }:
{
  imports = [
    ./proxmox.nix

    ../../modules/lib
    ../../modules/nix.nix
    ../../modules/programs/zsh.nix
    ../../modules/sops.nix
    ../../modules/syncthing.nix

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
    hostName = lib.mkForce "server";
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
