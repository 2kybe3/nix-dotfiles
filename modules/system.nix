{ pkgs, ... }:
{
  time.timeZone = "Europe/Berlin";

  hardware.bluetooth.enable = true;
  fonts.packages = with pkgs; [
    noto-fonts-color-emoji
    nerd-fonts.fira-code
    noto-fonts
    inter
  ];
}
