{
  self,
  config,
  ...
}: {
  sops.secrets.access-token = {
    path = "${config.home.homeDirectory}/.config/nix/access-tokens.conf";
    mode = "0400";
    sopsFile = "${self}/secrets/nix.conf.yaml";
  };

  home = {
    username = "kybe";
    homeDirectory = "/home/kybe";

    sessionVariables = {
      EDITOR = "nvim";
    };

    stateVersion = "25.11";
  };

  nix.extraOptions = "!include ${config.sops.secrets.access-token.path}";

  imports = [
    ./accounts.nix
    ./services
    ./programs
    ./sops.nix
  ];

  fonts.fontconfig = {
    enable = true;
    antialiasing = true;
    defaultFonts = {
      monospace = ["DepartureMono Nerd Font Mono"];
    };
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    font.name = "DepartureMono Nerd Font Mono";
  };

  xdg.enable = true;

  home.file = {
    ".config/wp.png".source = ./config/wp2.png;
  };
}
