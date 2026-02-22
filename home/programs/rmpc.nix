{
  lib,
  pkgs,
  ...
}: {
  home.packages = [pkgs.cava];
  programs.rmpc = {
    enable = true;
    config = lib.readFile ../config/rmpc/rmpc.ron;
  };
}
