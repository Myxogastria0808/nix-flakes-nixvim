{ ... }:
{
  # emmet-vim
  # reference: https://github.com/mattn/emmet-vim
  #
  # HTML/CSS abbreviation expansion (Emmet).
  # Usage: type abbreviation then press <C-y>, to expand (e.g. `!` → HTML boilerplate).
  #
  # Keymaps (Insert mode):
  # <C-y>, : expand abbreviation
  plugins.emmet = {
    enable = true;
    settings = {
      mode = "i";
      leader_key = "<C-y>";
    };
  };
}
