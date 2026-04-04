{ lib, ... }:
{
  imports = [
    ./plugins
  ];

  plugins.actions-preview.enable = true;
  lsp = {
    inlayHints.enable = true;
    keymaps = import ./keymaps.nix { inherit lib; };
  };
  extraConfigLua = ''
    vim.diagnostic.config({
        float = true,
        underline = true,
        virtual_lines = {
          enabled = true,
          current_line = true,
        },
    })
  '';
}
