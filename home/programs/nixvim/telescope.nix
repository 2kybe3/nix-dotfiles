{
  plugins.web-devicons.enable = true;
  plugins.telescope = {
    enable = true;
    keymaps = {
      "<leader>fp" = {
        action = "git_files";
        options = {
          desc = "Telescope Git Files";
        };
      };
      "<leader>ff" = "find_files";
      "<leader>fg" = "live_grep";
    };
  };
}
