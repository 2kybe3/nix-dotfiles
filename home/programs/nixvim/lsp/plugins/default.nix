{
  imports = [
    ./lsp.nix
    ./rustaceanvim.nix
  ];

  plugins = {
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        sources = [
          {
            name = "nixpkgs_maintainers";
            option = {
              cache_lifetime = 14;
              silent = false;
              nixpkgs_flake_uri = "github:NixOS/nixpkgs/master";
            };
          }
          {name = "async_path";}
          {name = "nvim_lsp";}
          {name = "luasnip";}
          {name = "buffer";}
          {name = "calc";}
        ];
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
        };
      };
    };
    crates = {
      enable = true;
      settings.lsp = {
        enabled = true;
        hover = true;
        actions = true;
        completion = true;
      };
    };
  };
}
