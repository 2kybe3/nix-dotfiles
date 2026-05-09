{
  self,
  pkgs,
  config,
  ...
}:
{
  sops.secrets.managarr = {
    path = "${config.home.homeDirectory}/.config/managarr/config.yml.bin";
    sopsFile = "${self}/secrets/managarr.yaml.bin";
    format = "binary";
  };

  home.packages = [ pkgs.managarr ];

}
