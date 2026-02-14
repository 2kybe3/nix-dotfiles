{pkgs, ...}: let
  pinentryWrapper = pkgs.writeShellScriptBin "pinentry-wrapper" ''
    #!/usr/bin/env bash
    if [ -n "$DISPLAY" ] || [ -n "$WAYLAND_DISPLAY" ]; then
      exec ${pkgs.pinentry-qt}/bin/pinentry-qt "$@"
    else
      exec ${pkgs.pinentry-curses}/bin/pinentry-curses "$@"
    fi
  '';
in {
  environment.systemPackages = with pkgs; [
    pinentry-curses
    pinentry-qt
  ];

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pinentryWrapper;
    enableSSHSupport = true;
  };
}
