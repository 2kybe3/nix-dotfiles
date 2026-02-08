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

  nix.extraOptions = "!include ${config.sops.secrets.access-token.path}";

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

  home.file.".config/wp.png".source = ./config/wp2.png;
}
