{lib, ...}: {
  programs.rmpc = {
    enable = true;
    config = lib.readFile ../config/rmpc/rmpc.ron;
  };
}
