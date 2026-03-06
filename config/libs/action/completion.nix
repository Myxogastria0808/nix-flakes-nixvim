{
  # nvim-cmp
  # reference: https://github.com/hrsh7th/nvim-cmp
  #
  # Completion engine with LSP, buffer word, and file path sources.
  #
  # Keymaps (Insert mode):
  # <C-n> : select next item
  # <C-p> : select previous item
  # <CR>  : confirm explicitly selected item (select = false: falls through to newline if none selected)
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
        "<CR>".__raw = "cmp.mapping.confirm({ select = false })";
        # Disable <C-y> to avoid conflict with emmet-vim (<C-y>, to expand)
        "<C-y>".__raw = "cmp.config.disable";
      };
    };
  };

  # completion sources
  plugins.cmp-nvim-lsp.enable = true;
  plugins.cmp-buffer.enable = true;
  plugins.cmp-path.enable = true;
}
