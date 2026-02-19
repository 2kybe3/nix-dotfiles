{
  lib,
  pkgs,
  ...
}: {
  programs.firejail.wrappedBinaries = {
    packettracer8 = {
      executable = lib.getExe pkgs.cisco-packet-tracer_9;
      extraArgs = [
        "--private"
        "--net=none"
        "--noprofile"
      ];
    };
  };
}
