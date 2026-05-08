{ pkgs, cpkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      jetbrains.datagrip
      element-desktop
      jetbrains.idea
      speedtest-cli
      wireshark
      wiremix
      vesktop
      delta
      just
      gimp

      # visualizer
      cava

      (prismlauncher.override {
        jdks = [
          jdk21
          jdk25
        ];
      })
    ]
    ++ (with cpkgs; [
      git-local-only
    ]);
}
