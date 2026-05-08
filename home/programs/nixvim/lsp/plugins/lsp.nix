{
  plugins.lsp = {
    enable = true;
    servers = {
      nil_ls = {
        enable = true;
        settings.nix.flake = {
          autoArchive = true;
        };
      };
      zls.enable = true;
      just.enable = true;
      ts_ls.enable = true;
      pylsp.enable = true;
      svelte.enable = true;
      yamlls.enable = true;
      statix.enable = true;
      jsonls.enable = true;
      bash_ls.enable = true;
      fish_lsp.enable = true;
      superhtml.enable = true;
      tailwindcss.enable = true;
      systemd_lsp.enable = true;
      postgres_lsp.enable = true;
      docker_language_service.enable = true;
      docker_compose_language_service.enable = true;
    };
  };
}
