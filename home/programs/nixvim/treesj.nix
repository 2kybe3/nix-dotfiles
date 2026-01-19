{
  plugins.treesj = {
    enable = true;
    settings = {
      use_default_keymaps = false;
      max_join_length = 1024;
    };
    luaConfig.post = ''
      vim.keymap.set('n', '<leader>m', require('treesj').toggle)
      vim.keymap.set('n', '<leader>M', function()
        require('treesj').toggle({ split = { recursive = true } })
      end)
    '';
  };
}
