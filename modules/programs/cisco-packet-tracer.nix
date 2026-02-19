{pkgs, ...}: {
  programs.firejail.wrappedBinaries = {
    packettracer9 = {
      executable = "${pkgs.cisco-packet-tracer_9}/bin/packettracer9";
      extraArgs = [
        "--private"
        "--net=none"
        "--noprofile"
      ];
    };
  };
}
