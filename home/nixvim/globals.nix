{
  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };
  opts = {
    number = true;
    undofile = true;
    ignorecase = true;
    smartcase = true;
    encoding = "utf8";
    termguicolors = true;
    wrap = false;
    smarttab = true;
    scrolloff = 10;

    tabstop = 4;
    softtabstop = 4;
    shiftwidth = 4;
    expandtab = true;
    autoindent = true;
    smartindent = true;
  };
  extraConfigLua = ''
    vim.g.mapleader = " "
    vim.g.maplocalleader = ","
    vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
    vim.keymap.set("v", "<Space>", "<Nop>", { silent = true })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "nix",
      callback = function()
        vim.opt.tabstop = 2
        vim.opt.softtabstop = 2
        vim.opt.shiftwidth = 2
      end,
    })
  '';
  plugins.fidget.enable = true;
}
