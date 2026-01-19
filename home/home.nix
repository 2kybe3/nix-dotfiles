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

  imports = [ ./i3.nix ];
  programs.nixvim.imports = [ ./nixvim ];

  xdg.enable = true;
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  ##### Services ######
  services.ssh-agent.enable = true;

  ##### Programs ######
  programs = {
    fd = {
      enable = true;
      hidden = true;
    };
    # TODO: configure btop here instead of a symlink
    zsh = {
      enable = true;
      history = {
        append = true;
        extended = true;
      };
      dotDir = "${config.xdg.configHome}/zsh";
      initContent = builtins.readFile ./config/zshrc;
      plugins = [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.8.0";
            sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
          };
        }
      ];
    };
    git = {
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
    home-manager.enable = true;
  };

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

      ##### BTOP #####
      ".config/btop/btop.conf".source = ./config/btop/btop.conf;

      ##### GIT #####
      ".gitconfig".source = ./config/git/gitconfig;

      ##### SSH #####
      ".ssh/config".source = ./config/ssh/config;
    }
  ];

  home.stateVersion = "25.11";
}
