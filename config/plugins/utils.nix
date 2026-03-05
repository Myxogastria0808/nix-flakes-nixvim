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
}
