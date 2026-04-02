{
  lsp = import ./lsp.nix;
  rustaceanvim = import ./rustaceanvim.nix;
  cmp = {
    enable = true;
    autoEnableSources = true;
    settings = {
      sources = [
        {name = "nvim_lsp";}
        {name = "luasnip";}
        {name = "buffer";}
      ];
      mapping = {
        "<C-Space>" = "cmp.mapping.complete()";
        "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
      };
    };
  };
  luasnip.enable = true;
}
