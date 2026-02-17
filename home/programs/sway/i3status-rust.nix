{
  self,
  pkgs,
  config,
  ...
}: {
  sops.secrets = {
    github-notifications = {
      sopsFile = "${self}/secrets/i3status.yaml";
    };
    "openweathermap/key" = {
      sopsFile = "${self}/secrets/i3status.yaml";
    };
    "openweathermap/zip" = {
      sopsFile = "${self}/secrets/i3status.yaml";
    };
  };

  home.packages = with pkgs; [
    i3status-rust
    (pkgs.writeShellScriptBin "i3status-rs-wrapper" ''
      export I3RS_GITHUB_TOKEN="$(cat ${config.sops.secrets.github-notifications.path})"
      export OPENWEATHERMAP_API_KEY="$(cat ${config.sops.secrets."openweathermap/key".path})"
      export OPENWEATHERMAP_ZIP="$(cat ${config.sops.secrets."openweathermap/zip".path})"
      exec ${i3status-rust}/bin/i3status-rs "$@"
    '')
  ];
  programs.i3status-rust = {
    enable = true;
    bars.default = {
      blocks = [
        {
          block = "disk_space";
          info_type = "available";
          interval = 60;
          warning = 20.0;
          alert = 10.0;
          path = "/";
        }
        {
          block = "memory";
          format = " $icon $mem_used.eng(prefix:Mi)/$mem_total.eng(prefix:Mi) ";
          interval = 1;
        }
        {
          block = "cpu";
          interval = 1;
        }
        {
          block = "bluetooth";
          mac = "2C:BE:EE:4A:5B:32";
        }
        {
          block = "music";
          player = ["mpd"];
          format = "{ $play $combo.str(max_w:25,rot_interval:0.1) |}";
        }
        {
          block = "music";
          player = ["firefox.instance_1_22"];
          format = "{ $play $combo.str(max_w:20,rot_interval:0.1) |}";
        }
        {
          block = "sound";
          format = " {$volume.eng(w:2) |}";
        }
        {
          block = "weather";
          service = {
            name = "openweathermap";
          };
          format = " $icon $weather $temp ";
        }
        {
          block = "time";
          format = " $timestamp.datetime(f:'%d.%m %H:%M') ";
          interval = 1;
        }
        {
          block = "github";
          hide_if_total_is_zero = true;
        }
      ];
      icons = "awesome6";
      theme = "bad-wolf";
    };
  };
}
