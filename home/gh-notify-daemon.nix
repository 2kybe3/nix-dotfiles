{
  self,
  config,
  ...
}:
{
  sops.secrets.gh-notify-daemon = {
    sopsFile = "${self}/secrets/gh-notify-daemon.yaml";
    key = "token";
  };

  gh-notify-daemon = {
    enable = true;
    secretFile = config.sops.secrets.gh-notify-daemon.path;
  };
}
