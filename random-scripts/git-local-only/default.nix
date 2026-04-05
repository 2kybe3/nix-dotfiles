{ pkgs }:
pkgs.writeScriptBin "git-local-only" ''
  #!${pkgs.bash}/bin/bash
  ${builtins.readFile ./script.sh}
''
