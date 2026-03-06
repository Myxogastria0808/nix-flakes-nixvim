{
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
  # Default keymaps (gcc, gbc, gc<motion>, gcO, gco, gcA) are all disabled.
  #
  # Keymaps:
  # <C-/>  : toggle line comment on current line  (Normal / Insert)
  # <C-/>  : toggle line comment on selection     (Visual)
  plugins.comment = {
    enable = true;
    settings = {
      mappings = {
        basic = false;
        extra = false;
      };
      pre_hook.__raw = ''
        require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      '';
    };
  };

  keymaps = [
    {
      mode = [
        "n"
        "i"
      ];
      key = "<C-/>";
      action.__raw = "function() require('Comment.api').toggle.linewise.current() end";
      options.desc = "Toggle line comment";
    }
    {
      mode = "x";
      key = "<C-/>";
      action.__raw = "function() require('Comment.api').toggle.linewise(vim.fn.visualmode()) end";
      options.desc = "Toggle line comment (selection)";
    }
  ];
}
