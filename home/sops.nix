{
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/nix/persist/var/lib/sops-nix/key.txt";
  };
}
