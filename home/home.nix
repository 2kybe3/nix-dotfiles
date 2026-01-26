{
  lib,
  pkgs,
  config,
  swayEnabled,
  ...
}:

{
  home = {
    username = "kybe";
    homeDirectory = "/home/kybe";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  imports = lib.optional swayEnabled ./sway;

  services = import ./services;
  programs = import ./programs/default.nix { inherit pkgs config; };

  fonts.fontconfig = {
    enable = true;
    antialiasing = true;
    defaultFonts = {
      monospace = [ "DepartureMono Nerd Font Mono" ];
    };
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    font.name = "DepartureMono Nerd Font Mono";
  };

  xdg.enable = true;

  home.file = lib.mkMerge [
    (lib.mkIf swayEnabled {
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
