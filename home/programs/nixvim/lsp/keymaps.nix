{ lib }:
[
  {
    action = lib.nixvim.mkRaw "require('telescope.builtin').lsp_definitions";
    key = "gd";
  }
  {
    action = lib.nixvim.mkRaw "require('telescope.builtin').lsp_references";
    key = "gD";
  }
  {
    key = "<leader>rr";
    lspBufAction = "rename";
  }
  {
    key = "<leader>ff";
    lspBufAction = "format";
  }
  {
    key = "K";
    lspBufAction = "hover";
  }
  {
    key = "<leader>fm";
    lspBufAction = "format";
  }
  {
    key = "<leader>ca";
    action = lib.nixvim.mkRaw "require('actions-preview').code_actions";
  }
  {
    action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=1, float=true }) end";
    key = "<leader>dj";
  }
  {
    action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=-1, float=true }) end";
    key = "<leader>dk";
  }
]
