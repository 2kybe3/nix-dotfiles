{
  self,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./gh-notify-daemon.nix
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
      !include ${config.sops.secrets.access-token.path};
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
    autostart.enable = true;
    mimeApps = {
      enable = true;
      defaultApplicationPackages = [
        pkgs.librewolf
        pkgs.thunderbird
      ];
      defaultApplications = {
        "x-scheme-handler/http" = ["librewolf.desktop"];
        "x-scheme-handler/https" = ["librewolf.desktop"];
        "x-scheme-handler/about" = ["librewolf.desktop"];
        "x-scheme-handler/unknown" = ["librewolf.desktop"];

        "x-scheme-handler/discord" = ["vesktop.desktop"];
      };
    };
    portal = {
      enable = true;
      config.common.default = "*";
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };
    userDirs = {
      enable = true;
      setSessionVariables = false;
    };
  };

  home.file = {
    ".config/wp.png".source = ./config/wp3.png;
    ".config/vesktop/themes/amoled-cord.theme.css".source = ./config/amoled-cord.theme.css;
  };
}
