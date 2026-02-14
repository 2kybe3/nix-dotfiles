{pkgs, ...}: {
  time.timeZone = "Europe/Berlin";

  hardware.bluetooth.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    inter
    noto-fonts
    noto-fonts-color-emoji
  ];
}
