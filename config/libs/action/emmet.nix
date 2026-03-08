{ lib, ... }:
{
  # emmet-vim
  # reference: https://github.com/mattn/emmet-vim
  #
  # HTML/CSS abbreviation expansion (Emmet).
  # Usage: type abbreviation then press <C-z>, to expand (e.g. `!` → HTML boilerplate).
  #
  # Keymaps (All modes):
  # <C-z>, : expand abbreviation
  plugins.emmet = {
    enable = true;
    settings = {
      leader_key = "<C-z>";
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
