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
  };

  home.packages = [ pkgs.managarr ];

}
