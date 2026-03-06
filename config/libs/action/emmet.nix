{ ... }:
{
  # emmet-vim
  # reference: https://github.com/mattn/emmet-vim
  #
  # HTML/CSS abbreviation expansion (Emmet).
  # Usage: type `!` then press <C-!> to expand to HTML boilerplate.
  #
  # Keymaps (Insert mode, HTML/CSS files only):
  # <C-!> : expand abbreviation (e.g. `!` → HTML boilerplate)
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
      key = "<C-!>";
      action.__raw = "emmet#expandAbbrIntelligently(\"\\<Tab>\")";
      options.expr = true;
    }
  ];
}
