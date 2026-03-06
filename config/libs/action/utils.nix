{ pkgs, ... }:
{
  # nvim-cmp
  # reference: https://github.com/hrsh7th/nvim-cmp
  #
  # Completion engine with LSP, buffer word, and file path sources.
  #
  # Keymaps (Insert mode):
  # <C-n>     : select next item
  # <C-p>     : select previous item
  # <C-y>     : confirm selected item
  # <C-Space> : trigger completion manually
  # <C-e>     : abort / close completion
  plugins.cmp = {
    enable = true;
    settings = {
      sources = [
        { name = "nvim_lsp"; }
        { name = "buffer"; }
        { name = "path"; }
      ];
      mapping = {
        "<C-n>".__raw = "cmp.mapping.select_next_item()";
        "<C-p>".__raw = "cmp.mapping.select_prev_item()";
        "<C-y>".__raw = "cmp.mapping.confirm({ select = true })";
        "<C-Space>".__raw = "cmp.mapping.complete()";
        "<C-e>".__raw = "cmp.mapping.abort()";
      };
    };
  };
  # completion sources
  plugins.cmp-nvim-lsp.enable = true;
  plugins.cmp-buffer.enable = true;
  plugins.cmp-path.enable = true;

  # nvim-autopairs
  # reference: https://github.com/windwp/nvim-autopairs
  #
  # Auto-closes brackets, quotes, and other pairs as you type.
  plugins.nvim-autopairs.enable = true;

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

  # toggleterm.nvim
  # reference: https://github.com/akinsho/toggleterm.nvim
  #
  # Keymaps:
  # <A-t> : toggle floating terminal (Normal / Insert / Terminal)
  plugins.toggleterm = {
    enable = true;
    settings.direction = "float";
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

  keymaps = [
    {
      mode = "n";
      key = "<A-j>";
      action = "<Plug>(jumpcursor-jump)";
      options.desc = "Jump cursor";
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
    # markdown-preview.nvim: toggle preview in browser
    {
      mode = "n";
      key = "<A-m>";
      action = "<cmd>MarkdownPreviewToggle<CR>";
      options.desc = "Toggle Markdown preview";
    }
  ];
}
