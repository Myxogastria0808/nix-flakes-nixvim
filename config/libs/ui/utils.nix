{
  opts = {
    # show line numbers
    number = true;
    # hide ~ at the end of buffer
    fillchars.eob = " ";
  };

  # noice.nvim
  # reference: https://github.com/folke/noice.nvim
  #
  # Replaces the default command line, messages, and pop-up UI
  # with a modern floating interface.
  plugins.noice.enable = true;

  # indent-blankline.nvim
  # reference: https://github.com/lukas-reineke/indent-blankline.nvim
  #
  # Displays indent guide lines with rainbow colors for each indent level.
  highlight = {
    # indent-blankline.nvim rainbow colors (one per indent level, muted)
    IblIndent1 = { fg = "#51303a"; };
    IblIndent2 = { fg = "#51402a"; };
    IblIndent3 = { fg = "#304830"; };
    IblIndent4 = { fg = "#284848"; };
    IblIndent5 = { fg = "#283848"; };
    IblIndent6 = { fg = "#3a2851"; };
  };

  plugins.indent-blankline = {
    enable = true;
    settings.indent = {
      # ▏ (U+258F) is a very thin left-edge vertical bar
      char = "▏";
      highlight = [
        "IblIndent1"
        "IblIndent2"
        "IblIndent3"
        "IblIndent4"
        "IblIndent5"
        "IblIndent6"
      ];
    };
  };

  # which-key.nvim
  # reference: https://github.com/folke/which-key.nvim
  #
  # Displays available keybindings in a popup when a prefix key is held.
  plugins.which-key.enable = true;

  # neoscroll.nvim
  # reference: https://github.com/karb94/neoscroll.nvim
  #
  # Smooth scrolling for C-u, C-d, C-f, C-b, C-e, C-y, zt, zz, zb.
  plugins.neoscroll.enable = true;

  # todo-comments.nvim
  # reference: https://github.com/folke/todo-comments.nvim
  #
  # Highlights and lists TODO, FIXME, NOTE, and other comment keywords.
  plugins.todo-comments.enable = true;
}
