{
  opts = {
    # show line numbers
    number = true;
    # hide ~ at the end of buffer
    fillchars.eob = " ";
  };

  # nvim-notify
  # reference: https://github.com/rcarriga/nvim-notify
  #
  # Fancy, configurable notification manager used as noice.nvim's backend.
  # Notification levels and their appearance:
  #   ERROR -> red border, stays until dismissed
  #   WARN  -> yellow border, auto-closes after timeout
  #   INFO  -> blue border, auto-closes after timeout
  plugins.notify = {
    enable = true;
    settings = {
      # animation style when showing / hiding notifications
      stages = "fade_in_slide_out";
      # default timeout in ms (overridden per-route via noice)
      timeout = 4000;
      # max width of notification window (in columns)
      max_width = 60;
      # max height of notification window (in rows)
      max_height = 10;
      # show notification level icons in the title bar
      icons = {
        ERROR = "❌";
        WARN = "⚠️";
        INFO = "ℹ️";
        DEBUG = "🐛";
        TRACE = "🔍";
      };
      render = "wrapped-compact";
    };
  };

  # noice.nvim
  # reference: https://github.com/folke/noice.nvim
  #
  # Replaces the default command line, messages, and pop-up UI
  # with a modern floating interface.
  # Uses nvim-notify as the notification backend.
  #
  # Routes:
  #   ERROR messages  → notify popup (persistent, red)
  #   WARN messages   → notify popup (auto-close, yellow)
  #   INFO messages   → notify popup (auto-close, blue)
  #   long messages   → split view (scrollable)
  plugins.noice = {
    enable = true;
    settings = {
      # delegate vim.notify() calls to nvim-notify
      notify.enabled = true;
      # show LSP progress in the bottom-right via nvim-notify
      lsp.progress.enabled = true;
      routes = [
        # Error messages: use notify with a longer timeout so they are hard to miss
        {
          filter = {
            event = "msg_show";
            kind = "error";
          };
          view = "notify";
          opts.level = "error";
        }
        # Warning messages: notify with default timeout
        {
          filter = {
            event = "msg_show";
            kind = "wmsg";
          };
          view = "notify";
          opts.level = "warn";
        }
        # Info messages: notify with default timeout
        {
          filter = {
            event = "msg_show";
            kind = "echo";
          };
          view = "notify";
          opts.level = "info";
        }
        # Long output (> 10 lines): open in a scrollable split instead of a pop-up
        {
          filter = {
            event = "msg_show";
            min_height = 10;
          };
          view = "split";
        }
      ];
    };
  };

  # indent-blankline.nvim
  # reference: https://github.com/lukas-reineke/indent-blankline.nvim
  #
  # Displays indent guide lines with rainbow colors for each indent level.
  highlight = {
    # indent-blankline.nvim rainbow colors (one per indent level, muted)
    IblIndent1 = {
      fg = "#51303a";
    };
    IblIndent2 = {
      fg = "#51402a";
    };
    IblIndent3 = {
      fg = "#304830";
    };
    IblIndent4 = {
      fg = "#284848";
    };
    IblIndent5 = {
      fg = "#283848";
    };
    IblIndent6 = {
      fg = "#3a2851";
    };
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
  # Highlights comment keywords. Supported patterns:
  #   TODO        : something to be done
  #   FIXME       : broken code that needs fixing
  #   BUG         : broken code that needs fixing
  #   FIXIT       : broken code that needs fixing
  #   ISSUE       : broken code that needs fixing
  #   HACK        : hacky workaround, should be refactored
  #   WARN        : warnings
  #   WARNING     : warnings
  #   XXX         : warnings
  #   PERF        : performance issues
  #   OPTIM       : performance issues
  #   PERFORMANCE : performance issues
  #   OPTIMIZE    : performance issues
  #   NOTE        : notes and information
  #   INFO        : notes and information
  #   TEST        : testing notes
  #   TESTING     : testing notes
  #   PASSED      : testing notes
  #   FAILED      : testing notes
  plugins.todo-comments.enable = true;
}
