{
  self,
  config,
  ...
}: {
  imports = [
    ./accounts.nix
    ./services
    ./programs
    ./sops.nix
  ];

  sops.secrets.access-token = {
    path = "${config.home.homeDirectory}/.config/nix/access-tokens.conf";
    sopsFile = "${self}/secrets/nix.conf.yaml";
    mode = "0400";
  };

  home = {
    username = "kybe";
    homeDirectory = "/home/kybe";

    sessionVariables = {
      EDITOR = "nvim";
    };

    stateVersion = "25.11";
  };

  nix = {extraOptions = "!include ${config.sops.secrets.access-token.path}";};

  fonts.fontconfig = {
    enable = true;
    antialiasing = true;
    defaultFonts = {
      monospace = ["FiraCode Nerd Font"];
      sansSerif = ["Inter"];
      serif = ["Noto Serif"];
      emoji = ["Noto Color Emoji"];
    };
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    font.name = "FiraCode Nerd Font";
  };

  xdg = {
    enable = true;
    userDirs.enable = true;
  };

  home.file = {
    ".config/wp.png".source = ./config/wp2.png;
    ".config/vesktop/themes/amoled-cord.theme.css".source = ./config/amoled-cord.theme.css;
  };
}
