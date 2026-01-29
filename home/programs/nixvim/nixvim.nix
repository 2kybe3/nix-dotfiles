{ pkgs, ... }:
{
  enable = true;

  extraPlugins = with pkgs.vimPlugins; [
    vim-tpipeline
  ];

  ## Default ##
  defaultEditor = true;

  ## Aliases ##
  vimAlias = true;
  viAlias = true;

  ## Clipboard ##
  clipboard = {
    register = "unnamedplus";
    clipboard.providers.wl-copy.enable = true;
  };

  ## Plugins
  plugins.fidget.enable = true;
  plugins.gitsigns.enable = true;
  plugins.render-markdown.enable = true;

  ## Colorsheme Catppuccin - Mocha ##
  colorschemes.catppuccin.enable = true;
  extraConfigLua = ''
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = true,
      float = {
        transparent = true,
        solid = false,
      }
    })
    vim.cmd.colorscheme "catppuccin"

    -- Leader 
    vim.g.mapleader = " "
    vim.g.maplocalleader = ","
    vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
    vim.keymap.set("v", "<Space>", "<Nop>", { silent = true })

    -- Zsh
    vim.filetype.add({
      filename = {
        ["zshrc"] = "zsh",
        [".zshrc"] = "zsh",
      },
    })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "nix",
      callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
      end,
    })
  '';
}
