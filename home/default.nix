{
  self,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./accounts.nix
    ./services
    ./programs
    ./sops.nix
    ./virt.nix
  ];

  sops.secrets = {
    access-token = {
      path = "${config.home.homeDirectory}/.config/nix/access-tokens.conf";
      sopsFile = "${self}/secrets/nix.conf.yaml";
      mode = "0400";
    };
    netrc = {
      path = "${config.home.homeDirectory}/.config/nix/netrc";
      sopsFile = "${self}/secrets/netrc.txt";
      format = "binary";
      mode = "0400";
    };
  };

  home = {
    username = "kybe";
    homeDirectory = "/home/kybe";

    sessionVariables = {
      EDITOR = "nvim";
    };

    stateVersion = "25.11";
  };

  nix = {
    package = pkgs.nix;
    extraOptions = ''
      netrc-file = ${config.sops.secrets.netrc.path}
      !include ${config.sops.secrets.access-token.path}";
    '';
  };

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
    gtk4.theme = null;
    colorScheme = "dark";
    font.name = "FiraCode Nerd Font";
  };

  xdg = {
    enable = true;
    userDirs.enable = true;
  };

  home.file = {
    ".config/wp.png".source = ./config/wp3.png;
    ".config/vesktop/themes/amoled-cord.theme.css".source = ./config/amoled-cord.theme.css;
  };
}
