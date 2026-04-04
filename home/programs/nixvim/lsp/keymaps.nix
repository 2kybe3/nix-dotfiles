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
    key = "K";
    lspBufAction = "hover";
  }
  {
    key = "<leader>ha";
    lspBufAction = "document_highlight";
  }
  {
    key = "<leader>hc";
    lspBufAction = "clear_references";
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
