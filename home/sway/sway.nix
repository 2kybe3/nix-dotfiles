{
  config,
  pkgs,
  lib,
  ...
}:

{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
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
            bindingMode = {
              border = "#000000";
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
      menu = "${pkgs.bemenu}/bin/bemenu-run";
      gaps = {
        inner = 0;
        outer = 0;
      };
      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
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
          "${modifier}+b" = "split h"; # b = h, v = v
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
    };
    extraConfig =
      let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in
      ''
        bindsym ${modifier}+o exec grim -g "$(slurp)" - | wl-copy
        bindsym ${modifier}+Shift+o exec ~/.config/kybe-scripts/sway/ss.bash
        default_border none
      '';
  };
}
