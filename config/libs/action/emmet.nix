{ ... }:
{
  # emmet-vim
  # reference: https://github.com/mattn/emmet-vim
  #
  # HTML/CSS abbreviation expansion (Emmet).
  # Usage: type abbreviation then press <A-e> to expand to HTML boilerplate.
  #
  # Keymaps (Insert mode, HTML/CSS files only):
  # <A-e> : expand abbreviation (e.g. `!` → HTML boilerplate)
  plugins.emmet = {
    enable = true;
    settings = {
      mode = "i";
      # Disable default leader key mappings
      install_global = 0;
    };
  };

  keymaps = [
    {
      mode = "i";
      key = "<A-e>";
      action.__raw = "function() return vim.fn[\"emmet#expandAbbrIntelligently\"](\"\\t\") end";
      options.expr = true;
    }
  ];
}
