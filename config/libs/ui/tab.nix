{
  # bufferline.nvim
  # reference: https://github.com/akinsho/bufferline.nvim
  #
  # Displays open buffers as file tabs at the top of the editor.
  #
  # Keymaps:
  # <A-]>        : go to next buffer     (Normal / Insert / Visual)
  # <A-[>        : go to previous buffer (Normal / Insert / Visual)
  # <A-d>        : close (delete) current buffer (Normal)
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
    # keybind: Alt + ]
    {
      mode = [
        "n"
        "i"
        "v"
      ];
      key = "<A-]>";
      action = "<cmd>BufferLineCycleNext<CR>";
      options.desc = "Next buffer";
    }
    # Move to the previous buffer in the bufferline.
    # Enabled in Normal / Insert / Visual to allow navigation from any editing context.
    # keybind: Alt + [
    {
      mode = [
        "n"
        "i"
        "v"
      ];
      key = "<A-[>";
      action = "<cmd>BufferLineCyclePrev<CR>";
      options.desc = "Previous buffer";
    }
    # Delete (close) the current buffer from the buffer list.
    # Uses the built-in :bdelete command; the window remains open.
    # Normal mode only to prevent accidental buffer close while editing or selecting.
    # keybind: Alt + D
    {
      mode = "n";
      key = "<A-d>";
      action = "<cmd>bdelete<CR>";
      options.desc = "Close buffer";
    }
  ];
}

