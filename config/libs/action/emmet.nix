{ ... }:
{
  # emmet-vim
  # reference: https://github.com/mattn/emmet-vim
  #
  # HTML/CSS abbreviation expansion (Emmet).
  # Usage: type abbreviation then press <C-y>, to expand (e.g. `!` → HTML boilerplate).
  #
  # Keymaps (All modes):
  # <C-y>, : expand abbreviation
  plugins.emmet.enable = true;

  globals = {
    user_emmet_mode = "a";
    user_emmet_leader_key = "<C-y>";
    user_emmet_settings = {
      html.snippets."!" = "<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n    <meta charset=\"UTF-8\">\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n    <title>Document</title>\n</head>\n<body>\n    \n</body>\n</html>";
    };
  };
}
