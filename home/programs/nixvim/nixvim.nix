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
  plugins = {
    fidget.enable = true; # Show what's going on
    vim-suda.enable = true; # :SudaRead / :SudaWrite
    whitespace.enable = true; # Show trailing whitespaces
    nix-develop.enable = true; # :NixDevelop / :NixShell
    render-markdown.enable = true;
    visual-whitespace.enable = true; # Visualize whitespaces in v mode
  };

  colorschemes.catppuccin.enable = true;
  extraConfigLua = ''
    require("catppuccin").setup({
      flavour = "macchiato",
      transparent_background = true,
      float = {
        transparent = true,
        solid = false,
      },
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
      },
      lsp_styles = {
        virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
            ok = { "italic" },
        },
        underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
            ok = { "underline" },
        },
        inlay_hints = {
            background = true,
        },
        integrations = {
          cmp = true,
          gitsigns = true,
        },
      },
    })
    vim.cmd("colorscheme catppuccin-nvim")

    -- Leader
    vim.g.mapleader = " "
    vim.g.maplocalleader = ","
    vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
    vim.keymap.set("v", "<Space>", "<Nop>", { silent = true })

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
