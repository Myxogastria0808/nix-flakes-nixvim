{ ... }:
{
  # emmet-vim
  # reference: https://github.com/mattn/emmet-vim
  #
  # HTML/CSS abbreviation expansion (Emmet).
  # Usage: type `!` then press <C-y>, to expand to HTML boilerplate.
  #
  # Keymaps (Insert mode, HTML/CSS files only):
  # <C-y>, : expand abbreviation (e.g. `!` → HTML boilerplate)
  plugins.emmet = {
    enable = true;
    settings = {
      # Only enable in HTML/CSS-related filetypes
      mode = "i";
      leader_key = "<C-y>";
    };
  };
}
