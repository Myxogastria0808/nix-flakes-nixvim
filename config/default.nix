{
  plugins = {
    #* file tree *#
    # neo-tree
    neo-tree = {
      enable = true;
      settings = {
        close_if_last_window = true;
        filesystem.follow_current_file.enabled = true;
        window = {
          position = "left";
          width = 30;
        };
      };
    };
    # icon
    web-devicons.enable = true;

    #* formatter *#
    conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          lsp_format = "fallback";
          timeout_ms = 500;
        };
        formatters_by_ft = {
          nix = [ "nixfmt" ];
        };
      };
    };

    #* LSP *#
    lsp = {
      enable = true;
      keymaps.lspBuf = { };
      servers = {
        nil_ls = {
          enable = true;
          settings.nix.flake.autoArchive = true;
        };
      };
    };
  };

  #* keymaps *#
  globals.mapleader = " ";
  keymaps = [
    # Ctrl+S で保存
    {
      mode = [
        "n"
        "i"
        "v"
      ];
      key = "<C-s>";
      action = "<cmd>w<CR>";
      options.desc = "Save file";
    }
    # Ctrl+N で neo-tree の開閉
    {
      mode = "n";
      key = "<C-n>";
      action = "<cmd>Neotree toggle<CR>";
      options.desc = "Toggle neo-tree";
    }

  ];
}
