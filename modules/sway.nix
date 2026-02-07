{pkgs, ...}: {
  security.polkit.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;

    config.common.default = "wlr";
  };

  # for i3status-rs
  fonts.packages = with pkgs; [
    font-awesome_6
  ];

  programs.dconf.enable = true;
}
