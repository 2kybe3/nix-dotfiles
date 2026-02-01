{
  lib,
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

    stateVersion = "25.11";
  };

  imports = lib.flatten [
    (lib.optional swayEnabled ./sway)
    ./accounts.nix
    ./services
    ./programs
    ./sops.nix
  ];

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

  home.file = {
    ".config/wp.png".source = ./config/wp2.png;
    ".config/kybe-scripts".source = ./config/scripts;
  };
}
