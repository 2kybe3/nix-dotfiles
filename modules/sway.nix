{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    sway.enable = lib.mkEnableOption "enables sway";
  };

  config = lib.mkIf config.sway.enable {
    security.polkit.enable = true;

    xdg.portal = {
      enable = true;
      wlr.enable = true;
    };

    # for i3status-rs
    fonts.packages = with pkgs; [
      font-awesome_6
    ];

    environment.systemPackages = with pkgs; [
      (pkgs.writeShellScriptBin "i3status-rs-wrapper" ''
        export I3RS_GITHUB_TOKEN="$(cat /run/secrets/github-notifications)"
        export OPENWEATHERMAP_API_KEY="$(cat /run/secrets/openweathermap/key)"
        export OPENWEATHERMAP_ZIP="$(cat /run/secrets/openweathermap/zip)"
        exec ${pkgs.i3status-rust}/bin/i3status-rs "$@"
      '')
      wl-clipboard-rs
      i3status-rust
      bemenu
      kitty
      dunst
      grim
      slurp
      jq
    ];

    programs.dconf.enable = true;

    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
  };
}
