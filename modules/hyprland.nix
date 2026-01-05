{ pkgs, ... }:
{
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    hyprpicker
    tofi
    hyprpolkitagent
    hyprcursor
    hyprsysteminfo
    hyprpaper
    ashell
    hyprshot
    dunst
    wl-clipboard-rs
    kitty
  ];

  # Clear tofi cache after installs incase .desktop files get added
  system.activationScripts = {
    tofi-cleanup.text = ''
      for userHome in /home/*; do
        rm "$userHome/.cache/tofi-drun" || true
      done
    '';
  };
}