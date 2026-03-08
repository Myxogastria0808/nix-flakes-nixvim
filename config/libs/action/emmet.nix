{ lib, ... }:
{
  # emmet-vim
  # reference: https://github.com/mattn/emmet-vim
  #
  # HTML/CSS abbreviation expansion (Emmet).
  # Usage: type abbreviation then press <M-z> or <C-z>, to expand (e.g. `!` → HTML boilerplate).
  #
  # Keymaps (Insert mode only):
  # <M-z>   : expand abbreviation (direct)
  # <C-z>,  : expand abbreviation (via leader key)
  plugins.emmet = {
    enable = true;
    settings = {
      leader_key = "<C-z>";
      mode = "i";
      settings = {
        html = {
          snippets = {
            "!" = ''
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
  };

  keymaps = [
    {
      mode = "i";
      key = "<M-z>";
      action = "<Plug>(emmet-expand-abbr)";
      options.silent = true;
    }
  ];

  # Fix: emmet-vim's emmet_utils.lua uses require("nvim-treesitter.ts_utils") which was
  # removed in nvim-treesitter v1. Override the module with the new vim.treesitter API.
  extraConfigLua = ''
    package.loaded["emmet_utils"] = {
      get_node_at_cursor = function()
        local node = vim.treesitter.get_node()
        if not node then return nil end
        while node do
          local t = node:type()
          if t == "element" then return "html"
          elseif t == "stylesheet" then return "css"
          end
          node = node:parent()
        end
        return ""
      end
    }
  '';
}
