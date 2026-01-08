{ ... }:
{
  enable = true;

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
  '';
}
