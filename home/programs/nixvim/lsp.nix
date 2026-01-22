{ lib }:
{
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
        action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=-1, float=true }) end";
        key = "<leader>dj";
      }
      {
        action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=1, float=true }) end";
        key = "<leader>dk";
      }
      {
        action = "<CMD>LspStop<CR>";
        key = "<leader>lx";
        mode = "n";
      }
      {
        action = "<CMD>LspStart<CR>";
        key = "<leader>ls";
        mode = "n";
      }
      {
        action = "<CMD>LspRestart<CR>";
        key = "<leader>lr";
        mode = "n";
      }
      {
        action = lib.nixvim.mkRaw "require('telescope.builtin').lsp_definitions";
        key = "gd";
      }
      {
        action = "<CMD>Lspsaga hover_doc<Enter>";
        key = "K";
      }
    ];
  };
  plugins = {
    lsp = {
      enable = true;
      servers = {
        nixd.enable = true;
        sqls.enable = true;
        html.enable = true;
        stylua.enable = true;
        nil_ls.enable = true;
        yamlls.enable = true;
        bash_ls.enable = true;
        superhtml.enable = true;
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
            "<leader>dc",
            function()
              vim.cmd.RustLsp({'renderDiagnostic', 'current'})
            end,
            { silent = true, buffer = bufnr }
          )
          vim.keymap.set(
            "n",
            "<leader>dn",
            function()
              vim.cmd.RustLsp({'renderDiagnostic', 'cycle'})
            end,
            { silent = true, buffer = bufnr }
          )
          vim.keymap.set(
            "n",
            "<leader>dp",
            function()
              vim.cmd.RustLsp({'renderDiagnostic', 'cycle_prev'})
            end,
            { silent = true, buffer = bufnr }
          )
          vim.keymap.set(
            "n",
            "<leader>dr",
            function()
              vim.cmd.RustLsp({'relatedDiagnostics'})
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
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "buffer"; }
        ];
        mapping = {
          "<C-e>" = "cmp.mapping.close()";
          "<C-Space>" = "cmp.mapping.complete()";
          "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
        };
      };
    };
    luasnip.enable = true;
  };
}
