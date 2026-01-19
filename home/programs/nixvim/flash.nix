{
  plugins.flash = {
    enable = true;
    luaConfig.post = ''
      vim.keymap.set({ "n", "x", "o" }, "zk", function() require("flash").jump() end, { desc = "flash" })
      vim.keymap.set("c", "<C-s>", function() require("flash").toggle() end, { desc = "toggle flash search" })
    '';
  };
}
