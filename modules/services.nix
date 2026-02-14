{
  imports = [
    ./getty.nix
    ./pipewire.nix
    ./printer.nix
    ./ssh.nix
    ./tor.nix
  ];
  services = {
    dbus.enable = true;
    mullvad-vpn.enable = true;
    gnome.gnome-keyring.enable = true;
  };
}
