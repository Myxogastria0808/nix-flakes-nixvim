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
  ];

  # indent-blankline.nvim
  # reference: https://github.com/lukas-reineke/indent-blankline.nvim
  #
  # Displays indent guide lines with rainbow colors for each indent level.
  highlight = {
    # indent-blankline.nvim rainbow colors (one per indent level)
    IblIndent1 = { fg = "#e06c75"; };
    IblIndent2 = { fg = "#e5c07b"; };
    IblIndent3 = { fg = "#98c379"; };
    IblIndent4 = { fg = "#56b6c2"; };
    IblIndent5 = { fg = "#61afef"; };
    IblIndent6 = { fg = "#c678dd"; };
    # Full-width character highlighting
    # Highlights full-width space (U+3000) and full-width alphanumeric/symbols (U+FF01-FF5E)
    ZenkakuChar = { bg = "#ffff00"; };
  };

  plugins.indent-blankline = {
    enable = true;
    settings.indent.highlight = [
      "IblIndent1"
      "IblIndent2"
      "IblIndent3"
      "IblIndent4"
      "IblIndent5"
      "IblIndent6"
    ];
  };

  extraConfigLua = ''
    vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
      callback = function()
        vim.fn.matchadd("ZenkakuChar", "[\u3000\uff01-\uff5e]")
      end,
    })
  '';
}
