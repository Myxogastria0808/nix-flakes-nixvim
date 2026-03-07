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
  plugins.emmet = {
    enable = true;
    leader = "<C-y>";
    mode = "a";
    settings = {
      html = {
        snippets = {
          "html:5" = ''
            <!DOCTYPE html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Document</title>
            </head>
            <body>
                |
            </body>
            </html>
          '';
        };
      };
    };
  };
}
