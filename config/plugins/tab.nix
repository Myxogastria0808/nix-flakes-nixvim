{
  # bufferline.nvim
  # reference: https://github.com/akinsho/bufferline.nvim
  #
  # Displays open buffers as file tabs at the top of the editor.
  #
  # Keymaps (Normal mode):
  # <S-l>        : go to next buffer
  # <S-h>        : go to previous buffer
  # <leader>bd   : close (delete) current buffer
  plugins.bufferline = {
    enable = true;
    settings.options = {
      # show × icon on each buffer tab
      show_buffer_close_icons = true;
      # show × icon on the tabline itself (far right)
      show_close_icon = true;
      # show file-type icon next to the filename
      show_buffer_icons = true;
      # separator style between tabs
      # available: "slant" | "padded_slant" | "slope" | "padded_slope" | "thick" | "thin"
      separator_style = "slant";
    };
  };

  keymaps = [
    # Move to the next buffer in the bufferline.
    # Mirrors the default Neovim window navigation convention (l = right).
    # keybind: Shift + L
    {
      mode = "n";
      key = "<S-l>";
      action = "<cmd>BufferLineCycleNext<CR>";
      options.desc = "Next buffer";
    }
    # Move to the previous buffer in the bufferline.
    # Mirrors the default Neovim window navigation convention (h = left).
    # keybind: Shift + H
    {
      mode = "n";
      key = "<S-h>";
      action = "<cmd>BufferLineCyclePrev<CR>";
      options.desc = "Previous buffer";
    }
    # Delete (close) the current buffer from the buffer list.
    # Uses the built-in :bdelete command; the window remains open.
    # keybind: Space -> B -> D
    {
      mode = "n";
      key = "<leader>bd";
      action = "<cmd>bdelete<CR>";
      options.desc = "Close buffer";
    }
  ];
}
