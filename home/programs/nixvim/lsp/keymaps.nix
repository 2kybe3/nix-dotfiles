{lib}: [
  {
    key = "gd";
    lspBufAction = "definition";
    mode = "n";
  }
  {
    key = "gD";
    lspBufAction = "references";
    mode = "n";
  }
  {
    key = "K";
    lspBufAction = "hover";
    mode = "n";
  }
  {
    key = "ha";
    lspBufAction = "document_highlight";
    mode = "n";
  }
  {
    key = "hc";
    lspBufAction = "clear_references";
    mode = "n";
  }
  {
    key = "ff";
    lspBufAction = "format";
    mode = "n";
  }
  {
    action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=1, float=true }) end";
    key = "<leader>dj";
  }
  {
    action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=-1, float=true }) end";
    key = "<leader>dk";
  }
  {
    action = lib.nixvim.mkRaw "require('telescope.builtin').lsp_definitions";
    key = "gd";
  }
]
