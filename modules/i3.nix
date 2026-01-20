{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    i3.enable = lib.mkEnableOption "enables i3";
  };

  config = lib.mkIf config.i3.enable {
    environment.pathsToLink = [ "/libexec" ];

    fonts.packages = with pkgs; [
      font-awesome_6
    ];

    sops.secrets.image-token = {
      owner = "kybe";
    };
    sops.secrets.github-notifications = {
      owner = "kybe";
    };
    sops.secrets."openweathermap/key" = {
      owner = "kybe";
    };
    sops.secrets."openweathermap/zip" = {
      owner = "kybe";
    };
    environment.systemPackages = with pkgs; [
      (pkgs.writeShellScriptBin "i3status-rs-wrapper" ''
        export I3RS_GITHUB_TOKEN="$(cat /run/secrets/github-notifications)"
        export OPENWEATHERMAP_API_KEY="$(cat /run/secrets/openweathermap/key)"
        export OPENWEATHERMAP_ZIP="$(cat /run/secrets/openweathermap/zip)"
        exec ${pkgs.i3status-rust}/bin/i3status-rs "$@"
      '')
      i3status-rust
      brightnessctl
      kitty
      dunst
      xclip
      maim
      feh
      jq
    ];

    programs.dconf.enable = true;

    services = {
      xserver = {
        enable = true;

        desktopManager = {
          xterm.enable = false;
        };

        windowManager.i3 = {
          enable = true;
          extraPackages = with pkgs; [
            dmenu
            i3status
          ];
        };
      };

      displayManager = {
        defaultSession = "none+i3";
        ly = {
          enable = true;
          settings = {
            animation = "doom";
            vi_mode = true;
            save = true;
          };
        };
      };
    };
  };
}
