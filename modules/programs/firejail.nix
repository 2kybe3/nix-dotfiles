{
  pkgs,
  config,
  ...
}: let
  make = config.kybe.lib.firejail.make;
in {
  programs.firejail = {
    enable = true;
    wrappedBinaries =
      (make pkgs.gnutar "tar" ["tar"])
      // (make pkgs.openssh "ssh" ["ssh"])
      // (make pkgs.unzip "unzip" ["unzip"])
      // (make pkgs.vesktop "vesktop" ["vesktop"])
      // (make pkgs.element-desktop "element-desktop" ["element-desktop"]);
  };
}
