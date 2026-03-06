{ pkgs, ... }:
{
  # todo-comments.nvim
  # reference: https://github.com/folke/todo-comments.nvim
  #
  # Highlights and lists TODO, FIXME, NOTE, and other comment keywords.
  plugins.todo-comments = {
    enable = true;
  };

  # jumpcursor.vim
  # reference: https://github.com/skanehira/jumpcursor.vim
  #
  # Keymaps:
  # <A-j> : jump cursor to any location in the file (Normal)
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "jumpcursor-vim";
      src = pkgs.fetchFromGitHub {
        owner = "skanehira";
        repo = "jumpcursor.vim";
        rev = "29669e27c0cbe65da8497c91585504bef846e255";
        hash = "sha256-WlH6VJiBy0rvFMvLjXA5pDjV6Rzv3luY1ueUrmGBwak=";
      };
    })
  ];

  keymaps = [
    {
      mode = "n";
      key = "<A-j>";
      action = "<Plug>(jumpcursor-jump)";
      options.desc = "Jump cursor";
    }
    {
      mode = "n";
      key = "<A-m>";
      action = "<cmd>MarkdownPreviewToggle<CR>";
      options.desc = "Toggle Markdown preview";
    }
    # toggleterm.nvim: toggle floating terminal
    {
      mode = [
        "n"
        "i"
        "t"
      ];
      key = "<A-t>";
      action = "<cmd>ToggleTerm<CR>";
      options.desc = "Toggle terminal";
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

  # nvim-autopairs
  # reference: https://github.com/windwp/nvim-autopairs
  #
  # Auto-closes brackets, quotes, and other pairs as you type.
  plugins.nvim-autopairs.enable = true;

  # neoscroll.nvim
  # reference: https://github.com/karb94/neoscroll.nvim
  #
  # Smooth scrolling for C-u, C-d, C-f, C-b, C-e, C-y, zt, zz, zb.
  plugins.neoscroll.enable = true;

  # toggleterm.nvim
  # reference: https://github.com/akinsho/toggleterm.nvim
  #
  # Keymaps:
  # <A-t> : toggle floating terminal (Normal / Insert / Terminal)
  plugins.toggleterm = {
    enable = true;
    settings.direction = "float";
  };

  # nvim-ts-context-commentstring
  # reference: https://github.com/JoosepAlviste/nvim-ts-context-commentstring
  #
  # Makes Comment.nvim context-aware in JSX/TSX:
  # uses {/* ... */} inside JSX expressions and // outside.
  # enable_autocmd = false: let Comment.nvim drive it via pre_hook instead.
  plugins.ts-context-commentstring = {
    enable = true;
    settings.enable_autocmd = false;
  };

  # Comment.nvim
  # reference: https://github.com/numToStr/Comment.nvim
  #
  # Keymaps (Normal mode):
  # gcc         : toggle line comment on current line
  # gbc         : toggle block comment on current line
  # gc<motion>  : toggle line comment over motion  (e.g. gc3j = comment 3 lines down)
  # gb<motion>  : toggle block comment over motion (e.g. gcip = comment inner paragraph)
  # gcO         : add comment line above
  # gco         : add comment line below
  # gcA         : add comment at end of line
  #
  # Keymaps (Visual mode):
  # gc          : toggle line comment on selection
  # gb          : toggle block comment on selection
  plugins.comment = {
    enable = true;
    settings.pre_hook.__raw = ''
      require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
    '';
  };

  # markdown-preview.nvim
  # reference: https://github.com/iamcco/markdown-preview.nvim
  #
  # Keymaps:
  # <A-m> : toggle Markdown preview in browser (Normal)
  plugins.markdown-preview = {
    enable = true;
    settings.auto_start = 0;
  };
}
