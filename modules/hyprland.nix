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
  ];
}