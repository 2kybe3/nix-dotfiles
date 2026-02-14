{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    pinentry-curses
    pinentry-qt
  ];

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
    enableSSHSupport = true;
  };
}
