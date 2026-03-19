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
      stages = "fade";
      # fallback timeout in ms for notifications that bypass noice routes
      # (noice routes override this with per-route opts.timeout)
      timeout = 1000;
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
  # source:    https://github.com/folke/noice.nvim/blob/main/lua/noice/ui/msg.lua
  #
  # Replaces the default command line, messages, and pop-up UI
  # with a modern floating interface.
  # Uses nvim-notify as the notification backend.
  #
  # ─── IMPORTANT: `event` and `kind` are tightly coupled ───────────────────────
  #
  # The `kind` field in a route filter has DIFFERENT meanings depending on
  # the `event` field.  Using a kind that does not belong to the given event
  # will silently never match, so routes will be dead without any error.
  #
  # ┌──────────────────┬────────────────────────────────────────────────────────────────┐
  # │ event            │ valid kind values                                              │
  # ├──────────────────┼────────────────────────────────────────────────────────────────┤
  # │ "msg_show"       │ see full table below (M.kinds in lua/noice/ui/msg.lua)         │
  # │ "notify"         │ log-level strings: "trace" "debug" "info" "warn" "error" "off" │
  # │ "lsp"            │ "progress"  "hover"  "message"  "signature"                    │
  # └──────────────────┴────────────────────────────────────────────────────────────────┘
  #
  # ─── Full kind table for event = "msg_show" ──────────────────────────────────
  #
  # ┌───────────────┬─────────────────┬─────────────────────────────────────────────────────┐
  # │ Category      │ kind            │ Description                                         │
  # ├───────────────┼─────────────────┼─────────────────────────────────────────────────────┤
  # │ echo          │ ""              │ Unknown / unclassified messages, vim.print() output  │
  # │               │ "echo"          │ :echo command output                                │
  # │               │ "echomsg"       │ :echomsg command output (added to :messages)         │
  # ├───────────────┼─────────────────┼─────────────────────────────────────────────────────┤
  # │ input/confirm │ "confirm"       │ confirm() / :confirm dialog                         │
  # │               │ "confirm_sub"   │ :substitute confirm dialog (:s_c)                   │
  # │               │ "number_prompt" │ inputlist() numeric prompt                          │
  # │               │ "return_prompt" │ press-enter prompt after multiple messages           │
  # │               │ "list_cmd"      │ :list command output                                │
  # ├───────────────┼─────────────────┼─────────────────────────────────────────────────────┤
  # │ errors        │ "emsg"          │ General error (:throw, internal errors…)            │
  # │               │ "echoerr"       │ :echoerr output                                     │
  # │               │ "lua_error"     │ Errors raised inside :lua blocks                    │
  # │               │ "rpc_error"     │ Error responses from rpcrequest()                   │
  # ├───────────────┼─────────────────┼─────────────────────────────────────────────────────┤
  # │ warnings      │ "wmsg"          │ Warnings ("search hit BOTTOM", W10…)                │
  # ├───────────────┼─────────────────┼─────────────────────────────────────────────────────┤
  # │ hints         │ "quickfix"      │ Quickfix navigation messages                        │
  # │               │ "search_count"  │ Search count ("S" flag of 'shortmess')              │
  # └───────────────┴─────────────────┴─────────────────────────────────────────────────────┘
  #
  # NOTE: "error" is NOT a valid kind for event = "msg_show".
  #       It belongs to event = "notify" only.
  #       The correct kind for Neovim error messages under msg_show is "emsg".
  #
  # Routes:
  #   ERROR messages  → notify popup (persistent, red)    [kind = "emsg"]
  #   WARN messages   → notify popup (auto-close, yellow) [kind = "wmsg"]
  #   INFO messages   → notify popup (auto-close, blue)   [kind = "echo"]
  #   long messages   → split view (scrollable)
  # Keymaps:
  #   <M-q>  : dismiss all visible notifications (Normal / Insert / Visual / Terminal / Command)
  keymaps = [
    # Dismiss all notifications that are currently visible on screen.
    # Does not affect notifications that are still pending in the queue.
    # keybind: Alt + Q
    {
      mode = [
        "n"
        "i"
        "v"
        "t"
        "c"
      ];
      key = "<M-q>";
      action = "<cmd>lua require('notify').dismiss({ silent = true, pending = false })<CR>";
      options.desc = "Dismiss all visible notifications";
    }
  ];

  plugins.noice = {
    enable = true;
    settings = {
      # delegate vim.notify() calls to nvim-notify
      notify.enabled = true;
      # show LSP progress in the bottom-right via nvim-notify
      lsp.progress.enabled = true;
      routes = [
        # Routes are evaluated top-to-bottom; the first match wins.
        #
        # Long output first — redirect to a split before any notify rule fires,
        # so large outputs don't flood the popup stack.
        {
          filter = {
            event = "msg_show";
            min_height = 10;
          };
          view = "split";
        }
        # ── error-level (2s) ───────────────────────────────────────────────────
        # General errors (:throw, internal errors, etc.)
        {
          filter = {
            event = "msg_show";
            kind = "emsg";
          };
          view = "notify";
          opts = {
            level = "error";
            timeout = 1000;
          };
        }
        # :echoerr output
        {
          filter = {
            event = "msg_show";
            kind = "echoerr";
          };
          view = "notify";
          opts = {
            level = "error";
            timeout = 1000;
          };
        }
        # Errors raised inside :lua blocks
        {
          filter = {
            event = "msg_show";
            kind = "lua_error";
          };
          view = "notify";
          opts = {
            level = "error";
            timeout = 1000;
          };
        }
        # Error responses from rpcrequest()
        {
          filter = {
            event = "msg_show";
            kind = "rpc_error";
          };
          view = "notify";
          opts = {
            level = "error";
            timeout = 1000;
          };
        }
        # ── warn-level (2s) ────────────────────────────────────────────────────
        # Warnings ("search hit BOTTOM", W10, etc.)
        {
          filter = {
            event = "msg_show";
            kind = "wmsg";
          };
          view = "notify";
          opts = {
            level = "warn";
            timeout = 1000;
          };
        }
        # ── info-level (1s) ────────────────────────────────────────────────────
        # Unknown / unclassified messages, vim.print() output
        {
          filter = {
            event = "msg_show";
            kind = "";
          };
          view = "notify";
          opts = {
            level = "info";
            timeout = 1000;
          };
        }
        # :echo output
        {
          filter = {
            event = "msg_show";
            kind = "echo";
          };
          view = "notify";
          opts = {
            level = "info";
            timeout = 1000;
          };
        }
        # :echomsg output (also added to :messages history)
        {
          filter = {
            event = "msg_show";
            kind = "echomsg";
          };
          view = "notify";
          opts = {
            level = "info";
            timeout = 1000;
          };
        }
        # confirm() / :confirm dialog
        {
          filter = {
            event = "msg_show";
            kind = "confirm";
          };
          view = "notify";
          opts = {
            level = "info";
            timeout = 1000;
          };
        }
        # :substitute confirm dialog (:s_c)
        {
          filter = {
            event = "msg_show";
            kind = "confirm_sub";
          };
          view = "notify";
          opts = {
            level = "info";
            timeout = 1000;
          };
        }
        # inputlist() numeric prompt
        {
          filter = {
            event = "msg_show";
            kind = "number_prompt";
          };
          view = "notify";
          opts = {
            level = "info";
            timeout = 1000;
          };
        }
        # press-enter prompt after multiple messages
        {
          filter = {
            event = "msg_show";
            kind = "return_prompt";
          };
          view = "notify";
          opts = {
            level = "info";
            timeout = 1000;
          };
        }
        # :list command output
        {
          filter = {
            event = "msg_show";
            kind = "list_cmd";
          };
          view = "notify";
          opts = {
            level = "info";
            timeout = 1000;
          };
        }
        # Quickfix navigation messages
        {
          filter = {
            event = "msg_show";
            kind = "quickfix";
          };
          view = "notify";
          opts = {
            level = "info";
            timeout = 1000;
          };
        }
        # Search count ("S" flag of 'shortmess') — fires on every search keystroke, can be noisy
        {
          filter = {
            event = "msg_show";
            kind = "search_count";
          };
          view = "notify";
          opts = {
            level = "info";
            timeout = 1000;
          };
        }
      ];
    };
  };
}
