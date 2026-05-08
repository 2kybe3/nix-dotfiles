{
  self,
  pkgs,
  config,
  ...
}:
{
  sops.secrets.managarr = {
    path = "${config.home.homeDirectory}/.config/managarr/config.yml";
    sopsFile = "${self}/secrets/managarr.yaml";
    format = "binary";
  };

  home.packages = [ pkgs.managarr ];

}
