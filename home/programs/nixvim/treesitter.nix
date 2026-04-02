{pkgs, ...}: {
  plugins.treesitter = {
    enable = true;
    highlight.enable = true;

    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      markdown
      vimdoc
      regex
      rust
      yaml
      bash
      make
      toml
      json
      lua
      nix
      vim
      xml
    ];
  };
  treesitter-textobjects.enable = true;
  treesitter-context.enable = true;
}
