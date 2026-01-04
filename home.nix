{ config, pkgs, ... }:

{
  home.username = "kybe";
  home.homeDirectory = "/home/kybe";
  programs.zsh = {
    enable = true;
    initContent = ''
      ssh-add ~/.ssh/kybe
    '';
  };

  home.stateVersion = "25.11";

  home.packages = [
  ];

  services.ssh-agent.enable = true;
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

  home.file = {
    ".icons/theme_NotwaitaBlack".source = ./theme_NotwaitaBlack;
    ".config/hypr/hyprland.conf".source = ./hypr/hyprland.conf;
    ".config/hypr/hyprpaper.conf".source = ./hypr/hyprpaper.conf;
    ".config/ashell/config.toml".source = ./ashell.toml;
    ".config/hypr/wp.png".source = ./wp.png;

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

  home.sessionVariables = {
    EDITOR = "vim";
  };


  programs.home-manager.enable = true;
}
