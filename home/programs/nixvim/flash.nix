{
  plugins.flash = {
    enable = true;
    luaConfig.post = ''
      vim.keymap.set({ "n", "x", "o" }, "zk", function() require("flash").jump() end, { desc = "flash" })
      vim.keymap.set({ "n", "x", "o" }, "Zk", function() require("flash").treesitter() end, { desc = "flash treesitter" })
      vim.keymap.set("c", "<c-s>", function() require("flash").toggle() end, { desc = "toggle flash search" })
    '';
  };
}
