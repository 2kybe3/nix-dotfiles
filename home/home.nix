{
  lib,
  pkgs,
  config,
  hyprlandEnabled,
  i3Enabled,
  ...
}:

{
  home = {
    username = "kybe";
    homeDirectory = "/home/kybe";
  };

  imports = lib.optional i3Enabled ./i3;

  xdg.enable = true;
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  ##### Services ######
  services.ssh-agent.enable = true;

  ##### Programs ######
  programs = import ./programs/default.nix { inherit pkgs config; };

  home.file = lib.mkMerge [
    (lib.mkIf hyprlandEnabled {
      ##### Hyprland #####
      ".icons/theme_NotwaitaBlack".source = ./config/hypr/theme-notwaita-black; # Hyprcursor Theme
      ".config/hypr/hyprland.conf".source = ./config/hypr/hyprland.conf; # Hyprland
      ".config/hypr/hyprpaper.conf".source = ./config/hypr/hyprpaper.conf; # Hyprpaper
      ".config/ashell/config.toml".source = ./config/ashell/ashell.toml; # Ashell (bar)
      ".config/tofi/config".source = ./config/tofi/config; # Tofi (app selector)
    })

    (lib.mkIf (hyprlandEnabled || i3Enabled) {
      ".config/dunst/dunstrc".source = ./config/dunst/dunstrc; # Dunstrc config (notification daemon)

      ##### Wallpaper #####
      ".config/wp.png".source = ./config/wp.png;
    })

    {
      ".tmux.conf".source = ./config/tmux/tmux.conf;
      ".config/kybe-scripts".source = ./config/scripts;

      ##### Himalaya #####
      ".config/himalaya/config.toml".source = ./config/himalaya/config.toml;

      ##### SSH #####
      ".ssh/config".source = ./config/ssh/config;
    }
  ];

  home.stateVersion = "25.11";
}
