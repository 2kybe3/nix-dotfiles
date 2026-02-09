{pkgs, ...}: {
  security.polkit.enable = true;

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

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
