{pkgs}: {
  make = pkg': profile: bins:
    builtins.listToAttrs (map (name: {
        name = "\"${name}\""; # quote so - are allowed (element-desktop)
        value = {
          executable = "${pkg'}/bin/${name}";
          profile = "${pkgs.firejail}/etc/firejail/${profile}.profile";
        };
      })
      bins);
}
