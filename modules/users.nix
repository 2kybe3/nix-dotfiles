{
  self,
  pkgs,
  cpkgs,
  inputs,
  config,
  system,
  screenshot-sway-zipline,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  sops.secrets = {
    root-pass = {
      sopsFile = "${self}/secrets/users.yaml";
      neededForUsers = true;
    };
    kybe-pass = {
      sopsFile = "${self}/secrets/users.yaml";
      neededForUsers = true;
    };
  };
  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;

    users = {
      root.hashedPasswordFile = config.sops.secrets.root-pass.path;

      kybe = {
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = [
          "acme"
          "wheel"
          "docker"
          "wireshark"
          "networkmanager"
        ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM7irWuDZwx7ZvPSiUwBbxUxKL/7aMQmy/8oxput1bID kybe@khost"
        ];
        hashedPasswordFile = config.sops.secrets.kybe-pass.path;
      };
    };
  };
}
