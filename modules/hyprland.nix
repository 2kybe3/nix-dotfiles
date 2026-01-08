{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    hyprland.enable = lib.mkEnableOption "enables hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    programs.hyprland.enable = true;

    environment.systemPackages = with pkgs; [
      wl-clipboard-rs
      hyprpolkitagent
      hyprsysteminfo
      hyprpicker
      hyprcursor
      hyprpaper
      hyprshot
      ashell
      dunst
      kitty
      tofi
    ];

    # Clear tofi cache after installs incase .desktop files get added
    system.activationScripts = {
      tofi-cleanup.text = ''
        for userHome in /home/*; do
          rm "$userHome/.cache/tofi-drun" &> /dev/null || true
        done
      '';
    };
  };
}
