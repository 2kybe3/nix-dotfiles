{pkgs, ...}: let
  serverHost = "10.0.5.6";
  nixosConfigPath = "~/.dotfiles";

  infraFolder = "~/infra";
  infraCaddyPath = "${infraFolder}/infra-caddy";
  infraCaddyHostPublic = "10.0.4.2";
  infraCaddyHostInternal = "10.0.5.2";
  infraBuilderPath = "${infraFolder}/infra-nix-builder";
  infraBuilderHost = "10.0.5.3";

  mkNixRebuild = {
    host,
    path,
    build-user ? "root",
    build-host,
    target-user ? "root",
    target-host,
  }: "sudo SSH_AUTH_SOCK=$SSH_AUTH_SOCK nixos-rebuild switch --flake ${path}#${host} --target-host ${target-user}@${target-host} --build-host ${build-user}@${build-host} --upgrade";
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
      knx-build = "sudo nixos-rebuild switch --flake ${nixosConfigPath}#knx --upgrade";
      knx-hm = "home-manager switch --flake ${nixosConfigPath} --show-trace";

      server-build = mkNixRebuild {
        host = "server";
        path = nixosConfigPath; # TODO: split server into a diff config
        build-host = serverHost;
        target-host = serverHost;
      };

      infra-nix-builder-build = mkNixRebuild {
        host = "nix-builder";
        path = infraBuilderPath;
        build-host = infraBuilderHost;
        target-host = infraBuilderHost;
      };

      infra-caddy-build =
        mkNixRebuild {
          host = "caddy-internal";
          path = infraCaddyPath;
          build-host = infraCaddyHostInternal;
          target-host = infraCaddyHostInternal;
        }
        + ";"
        + mkNixRebuild {
          host = "caddy-public";
          path = infraCaddyPath;
          build-host = infraCaddyHostPublic;
          target-host = infraCaddyHostPublic;
        };
    };
  };
}
