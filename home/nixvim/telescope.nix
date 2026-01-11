{
  plugins.web-devicons.enable = true;
  plugins.telescope = {
    enable = true;
    keymaps = {
      "<C-p>" = {
        action = "git_files";
        options = {
          desc = "Telescope Git Files";
        };
      };
      "<leader>fg" = "live_grep";
    };
  };
}
