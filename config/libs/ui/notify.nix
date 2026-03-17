{
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
        ERROR = "✘";
        WARN = "⚠";
        INFO = "🛈";
        DEBUG = "⚙";
        TRACE = "✏";
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
}
