{
  pkgs,
  ...
}:
{
  time.timeZone = "Europe/Berlin";

  hardware.bluetooth.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.departure-mono
    nerd-fonts.noto
  ];
}
