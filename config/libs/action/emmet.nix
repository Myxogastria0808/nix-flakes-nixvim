{ lib, ... }:
{
  # emmet-vim
  # reference: https://github.com/mattn/emmet-vim
  #
  # HTML/CSS abbreviation expansion (Emmet).
  # Usage: type abbreviation then press <C-y>, to expand (e.g. `!` → HTML boilerplate).
  #
  # Keymaps (All modes):
  # <C-y>, : expand abbreviation
  plugins.emmet = {
    enable = true;
    settings = {
      leader_key = "<C-y>";
      mode = "a";
      settings = {
        html = {
          snippets = {
            "html:5" = "<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n\t<meta charset=\"UTF-8\">\n\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n\t<title>Document</title>\n</head>\n<body>\n\t|\n</body>\n</html>";
          };
        };
      };
    };
  };
}
