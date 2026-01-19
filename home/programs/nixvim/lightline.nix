{
  plugins.lightline = {
    enable = true;
    settings = {
      colorscheme = "one";
      active = {
        left = [
          [
            "mode"
            "paste"
          ]
          [
            "gitbranch"
            "readonly"
            "filename"
            "modified"
          ]

        ];
        right = [
          [ "lineinfo" ]
          [ "percent" ]
          [
            "fileformat"
            "fileencoding"
            "filetype"
          ]
        ];
      };
    };
    luaConfig.post = ''
      vim.o.laststatus = 2
      vim.o.cmdheight = 1
    '';
  };
}
