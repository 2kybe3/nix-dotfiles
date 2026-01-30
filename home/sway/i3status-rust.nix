{ pkgs, ... }:
{
  home.packages = with pkgs; [
    i3status-rust
    (pkgs.writeShellScriptBin "i3status-rs-wrapper" ''
      export I3RS_GITHUB_TOKEN="$(cat /run/secrets/github-notifications)"
      export OPENWEATHERMAP_API_KEY="$(cat /run/secrets/openweathermap/key)"
      export OPENWEATHERMAP_ZIP="$(cat /run/secrets/openweathermap/zip)"
      exec ${pkgs.i3status-rust}/bin/i3status-rs "$@"
    '')
  ];
  programs.i3status-rust = {
    enable = true;
    bars = {
      default = {
        blocks = [
          {
            block = "disk_space";
            path = "/";
            interval = 60;
            warning = 20.0;
            alert = 10.0;
            info_type = "available";
          }
          {
            block = "memory";
            interval = 1;
          }
          {
            block = "disk_iostats";
            device = "sdc";
            interval = 1;
          }
          {
            block = "cpu";
            interval = 1;
          }
          {
            block = "github";
            hide_if_total_is_zero = true;
          }
          {
            block = "sound";
          }
          {
            block = "bluetooth";
            mac = "2C:BE:EE:4A:5B:32";
          }
          {
            block = "weather";
            service = {
              name = "openweathermap";
            };
          }
          {
            block = "time";
            format = " $timestamp.datetime(f:'%R %a %d') ";
            interval = 1;
          }
        ];
        icons = "awesome6";
        theme = "bad-wolf";
      };
    };
  };
}
