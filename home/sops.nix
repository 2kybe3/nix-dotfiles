{self, ...}: {
  sops = {
    defaultSopsFile = "${self}/secrets/secrets.yaml";
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/kybe/.age-key.txt";
  };
}
