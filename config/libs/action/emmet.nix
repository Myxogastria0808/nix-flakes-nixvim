{ ... }:
{
  # emmet-vim
  # reference: https://github.com/mattn/emmet-vim
  #
  # HTML/CSS abbreviation expansion (Emmet).
  # Usage: type `!` then press <A-!> to expand to HTML boilerplate.
  #
  # Keymaps (Insert mode, HTML/CSS files only):
  # <A-!> : expand abbreviation (e.g. `!` → HTML boilerplate)
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
      key = "<A-!>";
      action.__raw = "emmet#expandAbbrIntelligently(\"\\<Tab>\")";
      options.expr = true;
    }
  ];
}
