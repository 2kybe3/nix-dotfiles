{ pkgs, ... }:
{
  imports = [
    ../../modules/nix.nix
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

  programs.zsh.enable = true;
  users.users.root = {
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    vim
    git
  ];
  system.stateVersion = "25.05";
}
