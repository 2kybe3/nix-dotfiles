{
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
}
