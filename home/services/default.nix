{
  imports = [
    ./syncthing.nix
  ];
  services = {
    ssh-agent.enable = true;
  };
}
