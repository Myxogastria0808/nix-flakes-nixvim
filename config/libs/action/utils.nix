# utils.nix — Miscellaneous editing utility plugins.
# Plugins: nvim-autopairs (auto-close brackets/quotes), jumpcursor.vim (jump to any location),
#          markdown-preview.nvim (live browser preview with Mermaid support),
#          typst-preview.nvim (live browser preview for Typst documents).
# Also provides a LaTeX build keymap (<leader>b) using latexmk with lualatex.
{ pkgs, ... }:
{
  # nvim-autopairs
  # reference: https://github.com/windwp/nvim-autopairs
  #
  # Auto-closes brackets, quotes, and other pairs as you type.
  plugins.nvim-autopairs.enable = true;

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
    pkgs.vimPlugins.typst-preview-nvim
  ];

  # markdown-preview.nvim
  # reference: https://github.com/iamcco/markdown-preview.nvim
  #
  # Keymaps:
  # <A-m> : toggle Markdown preview in browser (Normal)
  plugins.markdown-preview = {
    enable = true;
    settings.auto_start = 0;
  };

  # typst-preview.nvim
  # reference: https://github.com/chomosuke/typst-preview.nvim
  #
  # Keymaps:
  # <A-p> : toggle Typst preview in browser (Normal)
  extraConfigLua = ''
    require("typst-preview").setup({})
  '';

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
    {
      mode = "n";
      key = "<A-p>";
      action = "<cmd>TypstPreviewToggle<CR>";
      options.desc = "Toggle Typst preview";
    }
    # Build the current LaTeX file to PDF using latexmk with lualatex engine.
    # latexmk handles BibTeX, cross-references, and recompilation automatically.
    # keybind: Space + B
    {
      mode = "n";
      key = "<leader>b";
      action = "<cmd>!latexmk -lualatex %<CR>";
      options.desc = "Build LaTeX to PDF (lualatex)";
    }
  ];
}

