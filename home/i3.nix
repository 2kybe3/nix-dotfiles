{
  config,
  pkgs,
  lib,
  i3Enabled,
  ...
}:

lib.mkIf i3Enabled {
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

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3;
    config = {
      bars = [
        {
          mode = "dock";
          hiddenState = "hide";
          position = "top";
          workspaceButtons = false;
          workspaceNumbers = false;
          statusCommand = "/run/current-system/sw/bin/i3status-rs-wrapper config-default.toml";
          fonts = {
            names = [ "monospace" ];
            size = 8.0;
          };
          trayOutput = "primary";
          colors = {
            background = "#000000";
            statusline = "#ffffff";
            separator = "#666666";
            focusedWorkspace = {
              border = "#1c1c1c";
              background = "#1c1c1c";
              text = "#ffffff";
            };
            activeWorkspace = {
              border = "#333333";
              background = "#5f676a";
              text = "#ffffff";
            };
            inactiveWorkspace = {
              border = "#333333";
              background = "#222222";
              text = "#888888";
            };
            urgentWorkspace = {
              border = "#2f343a";
              background = "#900000";
              text = "#ffffff";
            };
            bindingMode = {
              border = "#2f343a";
              background = "#900000";
              text = "#ffffff";
            };
          };
        }
      ];
      colors = {
        focused = {
          background = "#1c1c1c";
          border = "#1c1c1c";
          childBorder = "#1c1c1c";
          indicator = "#1c1c1c";
          text = "#ff5757";
        };
      };
      modifier = "Mod4";
      terminal = "kitty";
      menu = "${pkgs.dmenu}/bin/dmenu_run";
      gaps = {
        inner = 0;
        outer = 0;
      };
      keybindings =
        let
          modifier = config.xsession.windowManager.i3.config.modifier;
        in
        lib.mkOptionDefault {
          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";

          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";
          "${modifier}+c" = "split h"; # c = h, v = v
        };

      modes = {
        resize = {
          "Left" = "resize shrink width 10 px or 10 ppt";
          "j" = "resize grow height 10 px or 10 ppt";
          "k" = "resize shrink height 10 px or 10 ppt";
          "l" = "resize grow width 10 px or 10 ppt";
          "Escape" = "mode default";
          "Return" = "mode default";
        };
      };

      startup = [
        { command = "feh --bg-scale .config/wp.png"; }
      ];
    };
    extraConfig =
      let
        modifier = config.xsession.windowManager.i3.config.modifier;
      in
      ''
        bindsym ${modifier}+o exec maim --select | xclip -selection clipboard -t image/png
        bindsym ${modifier}+Shift+o exec ~/.config/kybe-scripts/i3/ss.bash
      '';
  };
}
