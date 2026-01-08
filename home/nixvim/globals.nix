{
  globals.mapleader = " ";
  opts = {
    number = true;
    encoding = "utf8";
    termguicolors = true;
    wrap = false;
    smarttab = true;
  };
  extraConfigLua = ''
    vim.g.mapleader = " "
    vim.g.maplocalleader = ","
    vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
    vim.keymap.set("v", "<Space>", "<Nop>", { silent = true })
    vim.keymap.set('n', '<leader>w', ':echo "Leader works!"<CR>')
  '';
}
