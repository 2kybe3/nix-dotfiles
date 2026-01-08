{
  lsp = {
    inlayHints.enable = true;
    keymaps = [
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
        key = "gt";
        lspBufAction = "type_definition";
        mode = "n";
      }
      {
        key = "gi";
        lspBufAction = "implementation";
        mode = "n";
      }
      {
        key = "K";
        lspBufAction = "hover";
        mode = "n";
      }
      {
        action = "<CMD>LspStop<CR>";
        key = "<leader>lx";
        mode = "n";
      }
      {
        action = "<CMD>LspStart<CR>";
        key = "<leader>ls";
        mode = "n";
      }
      {
        action = "<CMD>LspRestart<CR>";
        key = "<leader>lr";
        mode = "n";
      }
    ];
  };
  plugins.lsp = {
    enable = true;
    servers = {
      html.enable = true;
      nil_ls.enable = true;
      bash_ls.enable = true;
      rust_analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;
      };
      docker_language_service.enable = true;
      docker_compose_language_service.enable = true;
    };
  };
}
