{lib, ...}: {
  lsp = {
    inlayHints.enable = true;
    keymaps = import ./keymaps.nix {inherit lib;};
  };
  extraConfigLua = ''
    vim.diagnostic.config({
        float = true,
        underline = true,
        virtual_lines = true,
        update_in_insert = true,
    })
  '';
  plugins = import ./plugins;
}
