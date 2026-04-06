# utils.nix — Miscellaneous UI plugins and Vim options.
# Options: swapfile off + undofile on, line numbers, clipboard sync (unnamedplus),
#          eob fill char, global statusline (laststatus=3).
# Plugins: telescope.nvim + telescope-undo.nvim (undo history browser),
#          indent-blankline.nvim (6-level rainbow guides), which-key.nvim, neoscroll.nvim,
#          todo-comments.nvim (TODO / FIXME / HACK / WARN / NOTE / PERF / TEST and aliases).
{ pkgs, ... }:
{
  # delta — required by telescope-undo for rich diff preview
  extraPackages = [ pkgs.delta ];
  opts = {
    # Crash recovery strategy: persistent undo (undofile) instead of swap files.
    #
    # Swap file approach (Neovim default):
    #   Creates .swp files while editing. On crash the RECOVER/DELETE dialog
    #   appears. Pitfall: if the terminal emulator is killed (e.g. Ghostty
    #   closed), Neovim may survive as an orphan process keeping the swap
    #   file locked. Choosing DELETE in that state can discard file contents.
    #
    # Persistent undo approach (VSCode-like, used here):
    #   No .swp files are created; the RECOVER/DELETE dialog never appears.
    #   Undo history is saved to ~/.local/state/nvim/undo/ on every :w,
    #   so :u (undo) works across sessions — even after closing and reopening.
    #
    #   Scenario                          | swapfile  | undofile (this config)
    #   ----------------------------------|-----------|------------------------
    #   Terminal killed (last :w saved)   | swap dialog | opens normally
    #   Terminal killed (unsaved changes) | RECOVER     | unsaved part lost
    #   Revert to earlier saved states    | impossible  | :u across sessions
    swapfile = false;
    undofile = true;

    # show line numbers
    number = true;
    # hide ~ at the end of buffer
    fillchars.eob = " ";
    # sync yank with system clipboard
    clipboard = "unnamedplus";
    # Use a single global statusline shared across all windows (laststatus=3).
    #
    # The default (laststatus=2) renders a separate statusline per window.
    # When neo-tree is focused, the other windows become inactive and their
    # statuslines stay visible but dimmed — showing filename, location, etc.
    # even though they are not the active window.
    #
    # With laststatus=3 there is only one statusline for the entire editor,
    # so inactive-window bleed-through disappears entirely.
    # The `notNeoTree` cond in status-bar.nix already handles this case:
    # it hides filename/location components when neo-tree has focus, keeping
    # the global statusline clean.
    laststatus = 3;
  };

  # Set BAT_THEME so delta (used by telescope-undo for diff preview) uses
  # TwoDark, a bat built-in dark theme, instead of auto-detecting
  # "tokyonight" which is not in bat's theme directory.
  extraConfigLua = ''
    vim.env.BAT_THEME = "TwoDark"
  '';

  # telescope.nvim
  # reference: https://github.com/nvim-telescope/telescope.nvim
  #
  # Fuzzy finder framework. Currently used as the backend for telescope-undo.
  plugins.telescope = {
    enable = true;
  };

  # telescope-undo.nvim
  # reference: https://github.com/debugloop/telescope-undo.nvim
  #
  # Browse undo history in a telescope floating window with live diff preview.
  # Works with undofile so the history persists across sessions.
  #
  # Keymaps:
  # <A-u>    : open undo history in telescope               (Normal)
  #
  # Inside the telescope window (Insert):
  # <CR>     : yank additions from selected state           (Insert)
  # <S-CR>   : yank deletions from selected state           (Insert)
  # <C-CR>   : restore buffer to selected state             (Insert)
  # <C-y>    : yank deletions (terminal-compatible alt)     (Insert)
  # <C-r>    : restore (terminal-compatible alt)            (Insert)
  #
  # Inside the telescope window (Normal):
  # y        : yank additions from selected state           (Normal)
  # Y        : yank deletions from selected state           (Normal)
  # u        : restore buffer to selected state             (Normal)
  plugins.telescope.extensions.undo = {
    enable = true;
    settings = {
      use_delta = true;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<A-u>";
      action = "<cmd>Telescope undo<CR>";
      options.desc = "Undo history (telescope)";
    }
  ];

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

