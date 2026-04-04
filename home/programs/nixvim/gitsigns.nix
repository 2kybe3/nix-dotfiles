{
  plugins.gitsigns = {
    enable = true;
    settings = {
      numhl = true;
      signcolumn = false;
      current_line_blame = true;
      current_line_blame_opts = {
        delay = 500;
        virt_text = true;
        virt_text_pos = "eol";
      };
    };
  };
}
