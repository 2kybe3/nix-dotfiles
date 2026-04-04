{ lib }:
[
  {
    action = lib.nixvim.mkRaw "require('telescope.builtin').diagnostics";
    key = "<leader>dd";
  }
  {
    action = lib.nixvim.mkRaw "require('telescope.builtin').git_commits";
    key = "<leader>gc";
  }
  {
    action = lib.nixvim.mkRaw "require('telescope.builtin').git_branches";
    key = "<leader>gb";
  }
  {
    action = lib.nixvim.mkRaw "require('telescope.builtin').git_status";
    key = "<leader>gs";
  }
]
