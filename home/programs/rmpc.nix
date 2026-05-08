{
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [ cava ];
  programs.rmpc = {
    enable = true;
    config = lib.readFile ../config/rmpc/rmpc.ron;
  };
}
