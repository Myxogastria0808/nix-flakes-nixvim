# lspsaga.nix — Rich LSP UI using lspsaga.nvim (loaded via extraPlugins).
# Provides hover, finder, peek/goto definition, rename, code action, diagnostics, outline,
# breadcrumbs (symbol_in_winbar), call hierarchy, implementations, and a floating terminal.
{ pkgs, ... }:
{
  # lspsaga.nvim
  # reference: https://github.com/nvimdev/lspsaga.nvim
  #
  # Provides a rich LSP UI for diagnostics, hover, definitions, references,
  # rename, code actions, call hierarchy, outline, breadcrumbs, and a floating
  # terminal.
  #
  # Replaces:
  #   toggleterm.nvim              : float terminal → Lspsaga term_toggle
  #   vim.diagnostic.open_float() : built-in diagnostic → Lspsaga show_*_diagnostics
  #
  # Augments (replaces built-in LSP UI with rich floating UI):
  #   hover         (K)   → Lspsaga hover_doc
  #   go-to-def     (gd)  → Lspsaga goto_definition
  #   references    (gr)  → Lspsaga finder
  #   rename        (grn) → Lspsaga rename
  #   code action   (gra) → Lspsaga code_action
  #
  # New features (no prior equivalent):
  #   peek_definition / peek_type_definition : view definition without jumping
  #   goto_type_definition                   : jump to type definition
  #   finder                                 : unified refs + defs + impls view
  #   outline                                : symbol outline panel
  #   symbol_in_winbar                       : breadcrumb path in the winbar
  #   lightbulb                              : code action indicator on the sign column
  #   incoming_calls / outgoing_calls        : call hierarchy
  #   implement                              : implementation finder
  #
  # Keymaps:
  # K       : hover documentation                          (Normal)
  # <A-f>   : finder — refs / defs / impls in one view     (Normal)
  # gp      : peek definition (float, no jump)             (Normal)
  # gd      : go to definition                             (Normal)
  # gP      : peek type definition (float, no jump)        (Normal)
  # gT      : go to type definition                        (Normal)
  # <A-r>   : rename symbol project-wide                   (Normal)
  # <A-a>   : code action with live preview                (Normal / Visual)
  # <A-e>   : show line diagnostics                        (Normal)
  # <A-E>   : show cursor diagnostics                      (Normal)
  # ]d      : jump to next diagnostic                      (Normal)
  # [d      : jump to previous diagnostic                  (Normal)
  # <A-o>   : toggle outline panel                         (Normal)
  # <A-i>   : show incoming call hierarchy                 (Normal)
  # <A-u>   : show outgoing call hierarchy                 (Normal)
  # gi      : show implementations                         (Normal)
  # <A-t>   : toggle floating terminal                     (Normal / Terminal)

  extraPlugins = [ pkgs.vimPlugins.lspsaga-nvim ];

  extraConfigLua = ''
    require('lspsaga').setup({
      -- ── UI ──────────────────────────────────────────────────────────────
      -- Visual style applied to all lspsaga floating windows.
      ui = {
        -- border style: 'single' | 'double' | 'rounded' | 'solid' | 'shadow'
        border = 'rounded',
        -- icon shown next to available code actions
        code_action = '💡',
      },

      -- ── Lightbulb ───────────────────────────────────────────────────────
      -- Shows an indicator on lines where code actions are available,
      -- updating automatically as the cursor moves.
      lightbulb = {
        enable = true,
        -- show the lightbulb icon in the sign column
        sign = true,
        -- also show it as virtual text at the end of the line
        virtual_text = true,
      },

      -- ── Diagnostic ──────────────────────────────────────────────────────
      -- Controls the diagnostic float window triggered by <A-e> / <A-E>.
      diagnostic = {
        -- show a code action shortcut below the diagnostic message
        show_code_action = true,
        -- max width of the diagnostic float (fraction of screen width)
        max_width = 0.7,
        -- max height of the diagnostic float (fraction of screen height)
        max_height = 0.6,
        -- make the diagnostic text highlight follow the severity color
        text_hl_follow = true,
        -- make the float border color follow the severity color
        border_follow = true,
        keys = {
          -- execute the associated code action
          exec_action = 'o',
          -- close the diagnostic float
          quit = 'q',
          -- jump to the diagnostic location and close the float
          toggle_or_jump = '<CR>',
          -- close the full diagnostics list view
          quit_in_show = { 'q', '<ESC>' },
        },
      },

      -- ── Finder ──────────────────────────────────────────────────────────
      -- Unified view combining references, definitions, and implementations.
      -- Triggered by <A-f>.
      finder = {
        -- max height of the finder window (fraction of screen height)
        max_height = 0.5,
        -- width of the left symbol-list panel (fraction of finder width)
        left_width = 0.4,
        -- default sections shown: references + definitions + implementations
        default = 'ref+def+impl',
        layout = 'float',
        keys = {
          -- toggle expand or open the selected item
          toggle_or_open = 'o',
          -- open in a vertical split
          vsplit = 's',
          -- open in a horizontal split
          split = 'i',
          -- open in a new tab
          tabe = 't',
          -- close the finder
          quit = 'q',
        },
      },

      -- ── Hover ───────────────────────────────────────────────────────────
      -- Floating window showing LSP hover documentation.
      -- Triggered by K. Press K again to enter the float and scroll.
      hover = {
        -- max width of the hover window (fraction of screen width)
        max_width = 0.9,
        -- max height of the hover window (fraction of screen height)
        max_height = 0.8,
        -- key to open links inside hover docs (uses vim.ui.open)
        open_link = 'gx',
      },

      -- ── Rename ──────────────────────────────────────────────────────────
      -- Project-wide symbol rename with an inline input box.
      -- Triggered by <A-r>.
      rename = {
        -- do not auto-save modified buffers after rename (confirm manually)
        auto_save = false,
        keys = {
          -- abort and close the rename input
          quit = '<C-k>',
          -- confirm and apply the rename
          exec = '<CR>',
          -- select all references to preview before confirming
          select = 'x',
        },
      },

      -- ── Code Action ─────────────────────────────────────────────────────
      -- Pretty code action picker with live preview.
      -- Triggered by <A-a> in Normal and Visual mode.
      code_action = {
        -- enable number shortcuts (press 1–9 to pick an action directly)
        num_shortcut = true,
        -- show which LSP server provides each action
        show_server_name = false,
        -- do not integrate gitsigns hunks as extra code actions
        extend_gitsigns = false,
        keys = {
          -- close the picker without applying
          quit = 'q',
          -- apply the selected action
          exec = '<CR>',
        },
      },

      -- ── Outline ─────────────────────────────────────────────────────────
      -- IDE-style symbol outline panel.
      -- Triggered by <A-o>.
      outline = {
        -- open the panel on the right side of the screen
        win_position = 'right',
        -- width of the outline panel in columns
        win_width = 30,
        -- auto-preview the symbol under cursor in the source buffer
        auto_preview = true,
        -- keep the panel open after jumping to a symbol
        close_after_jump = false,
        -- show symbol detail (e.g. function signature) in the panel
        show_detail = true,
        keys = {
          -- expand/collapse or jump to the symbol under cursor
          toggle_or_jump = 'o',
          -- close the outline panel
          quit = 'q',
          -- jump to the symbol location in the source buffer
          jump = 'e',
        },
      },

      -- ── Symbol in Winbar (Breadcrumbs) ──────────────────────────────────
      -- Displays the current file path and symbol hierarchy in the winbar
      -- (the thin bar at the top of each window).
      -- No keymap — updates automatically as the cursor moves.
      symbol_in_winbar = {
        enable = true,
        -- separator between path segments
        separator = ' › ',
        -- include the file name at the start of the breadcrumb
        show_file = true,
        -- how many parent folder levels to show before the file name
        folder_level = 1,
        -- colorize each symbol kind with its highlight group
        color_mode = true,
        -- milliseconds to wait before updating the winbar after cursor move
        delay = 300,
      },

      -- ── Scroll Preview ──────────────────────────────────────────────────
      -- Keys for scrolling inside any lspsaga float window.
      scroll_preview = {
        scroll_down = '<C-f>',
        scroll_up   = '<C-b>',
      },

      -- ── Call Hierarchy ──────────────────────────────────────────────────
      -- Visualizes incoming (<A-i>) and outgoing (<A-u>) call relationships.
      callhierarchy = {
        layout = 'float',
        keys = {
          -- open the selected caller/callee in the current window
          edit = 'e',
          -- open in a vertical split
          vsplit = 's',
          -- open in a horizontal split
          split = 'i',
          -- open in a new tab
          tabe = 't',
          -- close the call hierarchy float
          quit = 'q',
          -- move focus between the hierarchy panel and preview
          shuttle = '[w',
          -- expand/collapse or request children for the selected node
          toggle_or_req = 'u',
        },
      },

      -- ── Implement ───────────────────────────────────────────────────────
      -- Virtual text indicator shown on interfaces / abstract types that have
      -- known implementations. The implementation list is opened via gi.
      implement = {
        enable = true,
        -- show the indicator in the sign column
        sign = true,
        -- also show it as virtual text at the end of the line
        virtual_text = true,
      },

      -- ── Beacon ──────────────────────────────────────────────────────────
      -- Briefly flashes the cursor after a jump so it is easy to spot.
      beacon = {
        enable = true,
        -- number of blink cycles
        frequency = 7,
      },
    })
  '';

  keymaps = [
    # Hover documentation for the symbol under the cursor.
    # Press K a second time to enter the float window and scroll.
    # keybind: K
    {
      mode = "n";
      key = "K";
      action = "<cmd>Lspsaga hover_doc<CR>";
      options.desc = "LSP hover documentation";
    }
    # Unified LSP finder: references, definitions, and implementations in one float.
    # keybind: Alt + F
    {
      mode = "n";
      key = "<A-f>";
      action = "<cmd>Lspsaga finder<CR>";
      options.desc = "LSP finder (refs / defs / impls)";
    }
    # Peek definition: open the definition in a float without jumping away.
    # keybind: gp
    {
      mode = "n";
      key = "gp";
      action = "<cmd>Lspsaga peek_definition<CR>";
      options.desc = "Peek definition";
    }
    # Go to definition: jump to the definition location.
    # Replaces the built-in gd.
    # keybind: gd
    {
      mode = "n";
      key = "gd";
      action = "<cmd>Lspsaga goto_definition<CR>";
      options.desc = "Go to definition";
    }
    # Peek type definition: open the type definition in a float without jumping away.
    # keybind: gP
    {
      mode = "n";
      key = "gP";
      action = "<cmd>Lspsaga peek_type_definition<CR>";
      options.desc = "Peek type definition";
    }
    # Go to type definition: jump to the type definition location.
    # keybind: gT
    {
      mode = "n";
      key = "gT";
      action = "<cmd>Lspsaga goto_type_definition<CR>";
      options.desc = "Go to type definition";
    }
    # Rename the symbol under the cursor across the entire project.
    # Replaces the built-in grn.
    # keybind: Alt + R
    {
      mode = "n";
      key = "<A-r>";
      action = "<cmd>Lspsaga rename<CR>";
      options.desc = "LSP rename";
    }
    # Open the code action picker with live preview.
    # Works in both Normal and Visual mode (visual selects the range).
    # Replaces the built-in gra.
    # keybind: Alt + A
    {
      mode = [
        "n"
        "v"
      ];
      key = "<A-a>";
      action = "<cmd>Lspsaga code_action<CR>";
      options.desc = "LSP code action";
    }
    # Show all diagnostics on the current line in a floating window.
    # Replaces vim.diagnostic.open_float() bound to <A-e>.
    # keybind: Alt + E
    {
      mode = "n";
      key = "<A-e>";
      action = "<cmd>Lspsaga show_line_diagnostics<CR>";
      options.desc = "Show line diagnostics";
    }
    # Show the diagnostic at the exact cursor position in a floating window.
    # Useful when multiple diagnostics exist on the same line.
    # keybind: Alt + Shift + E
    {
      mode = "n";
      key = "<A-E>";
      action = "<cmd>Lspsaga show_cursor_diagnostics<CR>";
      options.desc = "Show cursor diagnostics";
    }
    # Jump to the next diagnostic in the current buffer.
    # keybind: ]d
    {
      mode = "n";
      key = "]d";
      action = "<cmd>Lspsaga diagnostic_jump_next<CR>";
      options.desc = "Next diagnostic";
    }
    # Jump to the previous diagnostic in the current buffer.
    # keybind: [d
    {
      mode = "n";
      key = "[d";
      action = "<cmd>Lspsaga diagnostic_jump_prev<CR>";
      options.desc = "Previous diagnostic";
    }
    # Toggle the symbol outline panel on the right side.
    # keybind: Alt + O
    {
      mode = "n";
      key = "<A-o>";
      action = "<cmd>Lspsaga outline<CR>";
      options.desc = "Toggle symbol outline";
    }
    # Show incoming call hierarchy: who calls the symbol under the cursor?
    # keybind: Alt + I
    {
      mode = "n";
      key = "<A-i>";
      action = "<cmd>Lspsaga incoming_calls<CR>";
      options.desc = "Incoming call hierarchy";
    }
    # Show outgoing call hierarchy: what does the symbol under the cursor call?
    # keybind: Alt + U
    {
      mode = "n";
      key = "<A-u>";
      action = "<cmd>Lspsaga outgoing_calls<CR>";
      options.desc = "Outgoing call hierarchy";
    }
    # Show all implementations of the interface or abstract type under the cursor.
    # Replaces the built-in gi.
    # keybind: gi
    {
      mode = "n";
      key = "gi";
      action = "<cmd>Lspsaga finder imp<CR>";
      options.desc = "Show implementations";
    }
    # Toggle the floating terminal.
    # Replaces toggleterm.nvim (<A-t>).
    # keybind: Alt + T
    {
      mode = [
        "n"
        "t"
      ];
      key = "<A-t>";
      action = "<cmd>Lspsaga term_toggle<CR>";
      options.desc = "Toggle floating terminal";
    }
  ];
}

