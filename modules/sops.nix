{
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/nix/persist/var/lib/sops-nix/key.txt";

    secrets = {
      # users #
      root-pass.neededForUsers = true;
      kybe-pass.neededForUsers = true;
      # users #

      # i3status-rs #
      image-token.owner = "kybe";
      github-notifications.owner = "kybe";
      "openweathermap/key".owner = "kybe";
      "openweathermap/zip".owner = "kybe";
      # i3status-rs #

      # syncthing #
      syncthing.owner = "kybe";
      # syncthing #

      # email
      kybe-imap.owner = "kybe";
      # email #

      # Wireguard #
      "wireguard/key" = { };
      "wireguard/pk" = { };
      # Wireguard #
    };
  };
}
