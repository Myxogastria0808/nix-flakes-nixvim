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
      # Use <A-y> as leader to avoid nvim-cmp conflict with <C-y>
      leader_key = "<A-y>";
    };
  };

  keymaps = [
    {
      mode = "i";
      key = "<A-e>";
      action = "<C-r>=emmet#expandAbbrIntelligently(\"\\<Tab>\")<CR>";
    }
  ];
}
