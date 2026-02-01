{ pkgs, ... }:
{
  imports = [
    ./proxmox.nix
    ./hardware-configuration.nix

    ../../modules/nix.nix
    ../../modules/programs/zsh.nix
  ];

  boot = {
    loader.systemd-boot.enable = true;
  };

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
    hostId = "e775ce5";
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
