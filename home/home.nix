{ config, ... }:

{
  home.username = "kybe";
  home.homeDirectory = "/home/kybe";

  programs.nixvim.imports = [ ./nixvim ];

  xdg.enable = true;
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  ##### Services ######
  services.ssh-agent.enable = true;

  ##### Programs ######
  programs.fd = {
    enable = true;
    hidden = true;
  };
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    initContent = builtins.readFile ./config/zshrc;
  };
  programs.git = {
    enable = true;

    signing = {
      signByDefault = true;
      key = "A96D0830396F4327";
    };

    settings = {
      user = {
        name = "2kybe3";
        email = "kybe@kybe.xyz";
      };
      init.defaultBranch = "main";
    };
  };
  programs.home-manager.enable = true;

  home.file = {
    ##### Hyprland #####
    ".icons/theme_NotwaitaBlack".source = ./config/hypr/theme-notwaita-black; # Hyprcursor Theme
    ".config/hypr/hyprland.conf".source = ./config/hypr/hyprland.conf; # Hyprland
    ".config/hypr/hyprpaper.conf".source = ./config/hypr/hyprpaper.conf; # Hyprpaper
    ".config/ashell/config.toml".source = ./config/ashell/ashell.toml; # Ashell (bar)
    ".config/dunst/dunstrc".source = ./config/dunst/dunstrc; # Dunstrc config (notification daemon)
    ".config/tofi/config".source = ./config/tofi/config; # Tofi (app selector)

    ##### Himalaya #####
    ".config/himalaya/config.toml".source = ./config/himalaya/config.toml;

    ##### BTOP #####
    ".config/btop/btop.conf".source = ./config/btop/btop.conf;

    ##### Wallpaper #####
    ".config/hypr/wp.png".source = ./config/wp.png;

    ##### GIT #####
    ".gitconfig".source = ./config/git/gitconfig;

    ##### SSH #####
    ".ssh/config".source = ./config/ssh/config;
  };

  home.stateVersion = "25.11";
}
