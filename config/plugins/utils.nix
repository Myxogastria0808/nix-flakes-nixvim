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
    # indent-blankline.nvim rainbow colors (one per indent level, muted)
    IblIndent1 = { fg = "#51303a"; };
    IblIndent2 = { fg = "#51402a"; };
    IblIndent3 = { fg = "#304830"; };
    IblIndent4 = { fg = "#284848"; };
    IblIndent5 = { fg = "#283848"; };
    IblIndent6 = { fg = "#3a2851"; };
    # Full-width space (U+3000) and full-width alphanumeric/symbols (U+FF01-FF5E)
    ZenkakuChar = { bg = "#ffff00"; };
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

  extraConfigLua = ''
    vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
      callback = function()
        local fws = vim.fn.nr2char(0x3000)
        local fwstart = vim.fn.nr2char(0xff01)
        local fwend = vim.fn.nr2char(0xff5e)
        vim.fn.matchadd("ZenkakuChar", fws .. "\\|[" .. fwstart .. "-" .. fwend .. "]")
      end,
    })
  '';
}
