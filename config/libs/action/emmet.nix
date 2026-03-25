{ lib, ... }:
{
  # emmet-vim
  # reference: https://github.com/mattn/emmet-vim
  #
  # HTML/CSS abbreviation expansion (Emmet).
  # Usage: type abbreviation then press <A-z> to expand (e.g. `!` → HTML boilerplate).
  #
  # Keymaps:
  # <A-z> : expand Emmet abbreviation (Insert)
  plugins.emmet = {
    enable = true;
    settings = {
      # emmet-vim creates insert-mode mappings for every action as <leader_key><action_key>
      # (e.g. <C-z>, to expand, <C-z>; for word-expand, <C-z>u to update tag, etc.).
      # Using a real key like <C-z> as the leader causes Neovim to enter "wait for next key"
      # state whenever that key is pressed in insert mode, blocking other plugins from using it.
      # Setting the leader to a <Plug>(...) value makes all emmet leader-based mappings
      # unreachable from the keyboard (Plug mappings cannot be triggered by direct key input),
      # effectively disabling them. <A-z> is exposed instead via an explicit keymap below.
      leader_key = "<Plug>(emmet-leader)";
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
      key = "<A-z>";
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

