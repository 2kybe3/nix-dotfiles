{
  plugins.neo-tree = {
    enable = true;
    settings = {
      close_if_last_window = true;
      filesystem.follow_current_file = {
        enable = true;
        leave_dirs_open = true;
      };
      enable_git_status = true;
      enable_diagnostics = true;
    };
    luaConfig.post = ''
      vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>")
    '';
  };
}
