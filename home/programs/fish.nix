{pkgs, ...}: let
  serverHost = "nixos.internal.kybe.xyz";
  nixosConfigPath = "~/.dotfiles";

  infraFolder = "~/infra";
  infraCaddyPath = "${infraFolder}/infra-caddy";
  infraCaddyHostPublic = "caddy-public.internal.kybe.xyz";
  infraCaddyHostInternal = "caddy-internal.internal.kybe.xyz";
  infraBuilderPath = "${infraFolder}/infra-nix-builder";
  infraBuilderHost = "nix-builder.internal.kybe.xyz";

  mkNixRebuild = {
    host,
    path,
    build-user ? "root",
    build-host ? infraBuilderHost,
    target-user ? "root",
    target-host,
  }: "sudo SSH_AUTH_SOCK=$SSH_AUTH_SOCK nixos-rebuild switch --flake ${path}#${host} --target-host ${target-user}@${target-host} --build-host ${build-user}@${build-host} --upgrade  &| nom";
in {
  programs.fish = {
    enable = true;
    interactiveShellInit = builtins.readFile ../config/fish.fish;
    shellAliases = {
      cd = "z";
      ls = "${pkgs.eza}/bin/eza -al";
      tm = "tmux new-session -A -s main";

      # SSH stuff
      server = "ssh ip.kybe.xyz";

      # NIX stuff
      flake-update = "nix flake update --flake .";
      collect-garbage = "sudo nix-collect-garbage -d; nix-collect-garbage -d";
      knx-full = "knx-build; knx-hm";
      knx-build = "sudo SSH_AUTH_SOCK=$SSH_AUTH_SOCK nixos-rebuild switch --flake ${nixosConfigPath}#knx --build-host root@${infraBuilderHost} --upgrade &| nom";
      knx-hm = "home-manager switch --flake ${nixosConfigPath} --show-trace";

      server-build = mkNixRebuild {
        host = "server";
        path = nixosConfigPath; # TODO: split server into a diff config
        target-host = serverHost;
      };

      infra-nix-builder-build = mkNixRebuild {
        host = "nix-builder";
        path = infraBuilderPath;
        target-host = infraBuilderHost;
      };

      infra-caddy-build =
        mkNixRebuild {
          host = "caddy-internal";
          path = infraCaddyPath;
          target-host = infraCaddyHostInternal;
        }
        + ";"
        + mkNixRebuild {
          host = "caddy-public";
          path = infraCaddyPath;
          target-host = infraCaddyHostPublic;
        };
    };
  };
}
