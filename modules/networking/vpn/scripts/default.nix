{pkgs}: let
  scripts = [
    "vpn-on"
    "vpn-off"
    "vpn-toggle"
  ];
in
  map (name: pkgs.writeShellScriptBin name (builtins.readFile ./${name}.sh)) scripts
