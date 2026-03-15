{pkgs, ...}: {
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["kybe"];
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
  environment.systemPackages = with pkgs; [
    dnsmasq
  ];
  networking.firewall.trustedInterfaces = ["virbr0"];
}
