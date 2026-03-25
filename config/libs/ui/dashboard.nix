{
  # alpha-nvim
  # reference: https://github.com/goolord/alpha-nvim
  plugins.alpha = {
    enable = true;
    settings.layout = [
      {
        type = "padding";
        val = 1;
      }
      {
        type = "text";
        val = [
          "  ██╗           "
          "   ██╗          "
          "    ██╗         "
          "   █████╗       "
          "  ██╔╝  ██╗     "
          " ██╔╝    ╚██╗   "
          "╚═╝        ╚═╝  "
        ];
        opts = {
          position = "center";
          hl = "AlphaLambda";
        };
      }
      {
        type = "padding";
        val = 1;
      }
      {
        # Footer: Neovim version, dynamically rendered via raw Lua
        type = "text";
        val.__raw = ''
          (function()
            local v = vim.version()
            return { string.format("  Neovim v%d.%d.%d", v.major, v.minor, v.patch) }
          end)()
        '';
        opts = {
          position = "center";
          hl = "AlphaFooter";
        };
      }
    ];
  };

  highlight = {
    # Lambda symbol: soft purple
    AlphaLambda = {
      fg = "#bb9af7";
      bold = true;
    };
    # Footer: muted comment color
    AlphaFooter = {
      fg = "#565f89";
      italic = true;
    };
  };
}

