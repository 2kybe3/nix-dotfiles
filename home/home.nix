{ config, lib, ... }:

{
  home.username = "kybe";
  home.homeDirectory = "/home/kybe";

  programs.nixvim.enable = true;
  programs.nixvim.imports = [ ./nixvim.nix ];

  xdg.enable = true;
  home.sessionVariables = rec {
    EDITOR = "nvim";
  };

  ##### Services ######
  services.ssh-agent.enable = true;


  ##### Programs ######
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    initContent = ''
      ssh-add ~/.ssh/kybe > /dev/null 2>&1
    '';
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
        email = "2kybe3";
      };
      init.defaultBranch = "main";
    };
  };
  programs.home-manager.enable = true;

  home.file = {
    ".icons/theme_NotwaitaBlack".source = ./config/theme_NotwaitaBlack;
    ".config/hypr/hyprland.conf".source = ./config/hyprland.conf;
    ".config/hypr/hyprpaper.conf".source = ./config/hyprpaper.conf;
    ".config/ashell/config.toml".source = ./config/ashell.toml;
    ".config/hypr/wp.png".source = ./config/wp.png;

    ".config/dunst/dunstrc".source = ./config/dunstrc;

    ".ssh/config".text = ''
      Host kybe.xyz
        User root
        IdentityFile ~/.ssh/kybe
        IdentitiesOnly yes
    '';
    ".config/tofi/config".text = ''
      width = 100%
      height = 100%
      border-width = 0
      outline-width = 0
      padding-left = 40%
      padding-top = 40%
      result-spacing = 10
      num-results = 5
      font-size = 15
      font = monospace
      background-color = #000A
    '';
  };

  home.stateVersion = "25.11";
}
