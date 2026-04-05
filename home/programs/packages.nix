{ pkgs, ... }:
{
  home.packages = with pkgs; [
    jetbrains.datagrip
    element-desktop
    jetbrains.idea
    speedtest-cli
    wireshark
    wiremix
    vesktop
    delta
    gimp

    (prismlauncher.override {
      jdks = [
        jdk21
        jdk25
      ];
    })
  ];
}
