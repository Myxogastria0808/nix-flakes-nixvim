# completion.nix — Completion engine using nvim-cmp.
# Sources: LSP (nvim-lsp), buffer words, and file paths.
{
  # nvim-cmp
  # reference: https://github.com/hrsh7th/nvim-cmp
  #
  # Completion engine with LSP, buffer word, and file path sources.
  #
  # Keymaps:
  # <C-n> : select next item (Insert)
  # <C-p> : select previous item (Insert)
  # <CR>  : confirm selected item, or fall through to newline if none selected (Insert)
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
      };
    };
  };

  # completion sources
  plugins.cmp-nvim-lsp.enable = true;
  plugins.cmp-buffer.enable = true;
  plugins.cmp-path.enable = true;
}

