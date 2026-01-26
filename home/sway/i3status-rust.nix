{
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
            block = "disk_iostats";
            device = "sdc";
            interval = 1;
          }
          {
            block = "memory";
            interval = 1;
          }
          {
            block = "cpu";
            interval = 1;
          }
          {
            block = "vpn";
            driver = "mullvad";
            interval = 1;
          }
          {
            block = "docker";
            interval = 1;
          }
          {
            block = "github";
            hide_if_total_is_zero = true;
          }
          {
            block = "external_ip";
            format = " $ip $timezone $country_flag $asn ";
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
            format = " $timestamp.datetime(f:'%a %d/%m %R') ";
            interval = 1;
          }
          {
            block = "scratchpad";
          }
        ];
        icons = "awesome6";
        theme = "bad-wolf";
      };
    };
  };
}
