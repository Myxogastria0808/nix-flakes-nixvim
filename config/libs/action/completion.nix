{
  # nvim-cmp
  # reference: https://github.com/hrsh7th/nvim-cmp
  #
  # Completion engine with LSP, buffer word, and file path sources.
  #
  # Keymaps (Insert mode):
  # <C-n>     : select next item
  # <C-p>     : select previous item
  # <C-y>     : confirm selected item
  # <C-Space> : trigger completion manually
  # <C-e>     : abort / close completion
  plugins.cmp = {
    enable = true;
    settings = {
      sources = [
        { name = "nvim_lsp"; }
        { name = "buffer"; }
        { name = "path"; }
      ];
      mapping = {
        "<C-n>".__raw = "cmp.mapping.select_next_item()";
        "<C-p>".__raw = "cmp.mapping.select_prev_item()";
        "<C-y>".__raw = "cmp.mapping.confirm({ select = true })";
        "<C-Space>".__raw = "cmp.mapping.complete()";
        "<C-e>".__raw = "cmp.mapping.abort()";
      };
    };
  };

  # completion sources
  plugins.cmp-nvim-lsp.enable = true;
  plugins.cmp-buffer.enable = true;
  plugins.cmp-path.enable = true;
}
