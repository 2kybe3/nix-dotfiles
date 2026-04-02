{lib, ...}: {
  lsp = {
    inlayHints.enable = true;
    keymaps = [
      {
        key = "gd";
        lspBufAction = "definition";
        mode = "n";
      }
      {
        key = "gD";
        lspBufAction = "references";
        mode = "n";
      }
      {
        key = "gt";
        lspBufAction = "type_definition";
        mode = "n";
      }
      {
        key = "gi";
        lspBufAction = "implementation";
        mode = "n";
      }
      {
        key = "K";
        lspBufAction = "hover";
        mode = "n";
      }
      {
        action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=1, float=true }) end";
        key = "<leader>dj";
      }
      {
        action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=-1, float=true }) end";
        key = "<leader>dk";
      }
      {
        action = lib.nixvim.mkRaw "require('telescope.builtin').lsp_definitions";
        key = "gd";
      }
    ];
  };
  plugins = {
    lsp = {
      enable = true;
      servers = {
        jus.enable = true;
        nixd = {
          enable = true;
          config = {
            nixpkgs = {
              expr = "import <nixpkgs> { }";
            };
            options = {
              nixos.expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.knx.options";
              nixvim.expr = "(builtins.getFlake (builtins.toString ./.)).inputs.nixvim.nixvimConfigurations.${builtins.currentSystem}.default.options";
              home-manager.expr = "(builtins.getFlake (builtins.toString ./.)).homeConfigurations.kybe.options";
            };
          };
        };
        html.enable = true;
        yamlls.enable = true;
        nil_ls.enable = true;
        bash_ls.enable = true;
        fish_lsp.enable = true;
        systemd_lsp.enable = true;
        docker_language_service.enable = true;
        docker_compose_language_service.enable = true;
      };
    };
    rustaceanvim = {
      enable = true;
      settings.server.on_attach = ''
        function(client, bufnr)
          vim.keymap.set(
            "n",
            "K",
            function()
              vim.cmd.RustLsp({'hover', 'actions'})
            end,
            { silent = true, buffer = bufnr }
          )
          vim.keymap.set(
            "n",
            "<leader>dj",
            function()
              vim.cmd.RustLsp({'renderDiagnostic', 'cycle'})
            end,
            { silent = true, buffer = bufnr }
          )
          vim.keymap.set(
            "n",
            "<leader>dk",
            function()
              vim.cmd.RustLsp({'renderDiagnostic', 'cycle_prev'})
            end,
            { silent = true, buffer = bufnr }
          )
          vim.keymap.set(
            "n",
            "<leader>ca",
            function()
              vim.cmd.RustLsp({'codeAction'})
            end,
            { silent = true, buffer = bufnr }
          )
          vim.keymap.set(
            "n",
            "<leader>j",
            function()
              vim.cmd.RustLsp({'moveItem', 'down'})
            end,
            { silent = true, buffer = bufnr }
          )
          vim.keymap.set(
            "n",
            "<leader>k",
            function()
              vim.cmd.RustLsp({'moveItem', 'up'})
            end,
            { silent = true, buffer = bufnr }
          )
          vim.keymap.set(
            "n",
            "<leader>od",
            function()
              vim.cmd.RustLsp({'openDocs'})
            end,
            { silent = true, buffer = bufnr }
          )
        end,
      '';
    };
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
  };
}
