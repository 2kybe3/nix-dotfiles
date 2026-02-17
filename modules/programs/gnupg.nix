{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    pinentry-qt
  ];

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
    enableSSHSupport = true;
  };
}
