{ modulesPath, ...}:
{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  proxmoxLXC = {
    manageNetwork = false;
    privileged = false;
  };
  security.pam.services.sshd.allowNullPassword = true;
  services.fstrim.enable = false;
}
