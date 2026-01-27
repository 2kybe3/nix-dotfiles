{ pkgs, config }:
{
  defaultUserShell = pkgs.zsh;
  mutableUsers = false;
  users.root = {
    hashedPasswordFile = config.sops.secrets.root-pass.path;
  };

  users.kybe = {
    isNormalUser = true;
    description = "2kybe3";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM7irWuDZwx7ZvPSiUwBbxUxKL/7aMQmy/8oxput1bID kybe@khost"
    ];
    hashedPasswordFile = config.sops.secrets.kybe-pass.path;
  };

}
