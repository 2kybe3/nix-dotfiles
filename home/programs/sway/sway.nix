{
  self,
  pkgs,
  config,
  screenshot-sway-zipline,
  ...
}: {
  sops.secrets = {
    image-token.sopsFile = "${self}/secrets/i3status.yaml";
    keepass = {
      sopsFile = "${self}/secrets/keepass.yaml";
      key = "key";
    };
  };

  home.packages = with pkgs; [
    kitty
    swaybg
    bemenu
    polkit_gnome
    wl-clipboard-rs

    # SS
    dunst
    grim
    slurp
    jq
  ];

  xdg.autostart.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    systemd.xdgAutostart = config.xdg.autostart.enable;

    checkConfig = false;

    wrapperFeatures.gtk = true;

    config = {
      modifier = "Mod4";
      terminal = "kitty";
      menu = "${pkgs.bemenu}/bin/bemenu-run";

      bars = [
        {
          mode = "dock";
          hiddenState = "hide";
          position = "top";
          workspaceButtons = false;
          workspaceNumbers = false;
          statusCommand = "i3status-rs-wrapper config-default.toml";
          fonts = {
            names = ["monospace"];
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

      startup = [
        {command = "kitty";}
        {command = "vesktop";}
        {command = "firefox";}
        {command = "swaybg -i /home/kybe/.config/wp.png";}
      ];

      window = {
        border = 1;
        titlebar = false;
      };

      keybindings = let
        inherit
          (config.wayland.windowManager.sway.config)
          modifier
          terminal
          menu
          ;
      in {
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+Shift+q" = "kill";
        "${modifier}+d" = "exec ${menu}";

        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+a" = "focus parent";

        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";

        "${modifier}+Shift+space" = "floating toggle";
        "${modifier}+space" = "focus mode_toggle";
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";

        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";

        "${modifier}+Shift+minus" = "move scratchpad";
        "${modifier}+minus" = "scratchpad show";

        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+e" = "exec swaynag -t warning -m 'EXIT?' -b 'Yes' 'swaymsg exit'";

        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";

        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";
        "${modifier}+v" = "split v"; # b = h, v = v
        "${modifier}+b" = "split h"; # b = h, v = v
      };
    };

    extraConfig = let
      inherit
        (config.wayland.windowManager.sway.config)
        modifier
        ;
    in ''
      bindsym ${modifier}+o exec grim -g "$(slurp)" - | wl-copy
      bindsym ${modifier}+Shift+o exec ${screenshot-sway-zipline}/bin/screenshot-sway-zipline https://i.kybe.xyz/api/upload ${config.sops.secrets.image-token.path}

      blur enable
      blur_xray disable
      blur_passes 5
      blur_radius 5

      shadows enable

      default_dim_inactive 0.2
    '';
  };
}
