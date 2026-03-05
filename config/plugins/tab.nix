{
  # bufferline.nvim
  # reference: https://github.com/akinsho/bufferline.nvim
  #
  # Displays open buffers as file tabs at the top of the editor.
  #
  # Keymaps:
  # <A-L>        : go to next buffer     (Normal / Insert / Visual)
  # <A-H>        : go to previous buffer (Normal / Insert / Visual)
  # <A-D>        : close (delete) current buffer (Normal only, to avoid accidental close)
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
    # Enabled in Normal / Insert / Visual to allow navigation from any editing context.
    # keybind: Shift + Alt + L
    {
      mode = [
        "n"
        "i"
        "v"
      ];
      key = "<A-L>";
      action = "<cmd>BufferLineCycleNext<CR>";
      options.desc = "Next buffer";
    }
    # Move to the previous buffer in the bufferline.
    # Mirrors the default Neovim window navigation convention (h = left).
    # Enabled in Normal / Insert / Visual to allow navigation from any editing context.
    # keybind: Shift + Alt + H
    {
      mode = [
        "n"
        "i"
        "v"
      ];
      key = "<A-H>";
      action = "<cmd>BufferLineCyclePrev<CR>";
      options.desc = "Previous buffer";
    }
    # Delete (close) the current buffer from the buffer list.
    # Uses the built-in :bdelete command; the window remains open.
    # Normal mode only to prevent accidental buffer close while editing or selecting.
    # keybind: Shift + Alt + D
    {
      mode = "n";
      key = "<A-D>";
      action = "<cmd>bdelete<CR>";
      options.desc = "Close buffer";
    }
  ];
}
