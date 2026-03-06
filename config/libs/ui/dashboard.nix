{
  # alpha-nvim
  # reference: https://github.com/goolord/alpha-nvim
  #
  # Displays a rich start screen (dashboard) when Neovim is opened without
  # file arguments. Provides quick-access buttons and a Neovim logo header.
  #
  # Button shortcuts (on the dashboard):
  # n : new empty buffer
  # e : file explorer (Neo-tree)
  # q : quit Neovim
  plugins.alpha = {
    enable = true;
    settings.layout = [
      {
        type = "padding";
        val = 4;
      }
      {
        # Neovim logo in box-drawing characters
        type = "text";
        val = [
          "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗"
          "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║"
          "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║"
          "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║"
          "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║"
          "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝"
        ];
        opts = {
          position = "center";
          hl = "AlphaNvimHeader";
        };
      }
      {
        type = "padding";
        val = 2;
      }
      {
        type = "group";
        val = [
          {
            type = "button";
            val = "  New File";
            on_press.__raw = "function() vim.cmd('enew') end";
            opts = {
              shortcut = "n";
              position = "center";
              width = 44;
              hl = "AlphaButton";
              hl_shortcut = "AlphaButtonShortcut";
              cursor = 3;
              align_shortcut = "right";
            };
          }
          {
            type = "button";
            val = "  File Explorer";
            on_press.__raw = "function() vim.cmd('Neotree toggle') end";
            opts = {
              shortcut = "e";
              position = "center";
              width = 44;
              hl = "AlphaButton";
              hl_shortcut = "AlphaButtonShortcut";
              cursor = 3;
              align_shortcut = "right";
            };
          }
          {
            type = "button";
            val = "  Quit";
            on_press.__raw = "function() vim.cmd('qa') end";
            opts = {
              shortcut = "q";
              position = "center";
              width = 44;
              hl = "AlphaButton";
              hl_shortcut = "AlphaButtonShortcut";
              cursor = 3;
              align_shortcut = "right";
            };
          }
        ];
        opts.spacing = 1;
      }
      {
        type = "padding";
        val = 2;
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

  # Highlight groups for the dashboard, matching tokyonight-night palette.
  highlight = {
    # Header: bright blue (tokyonight blue)
    AlphaNvimHeader = {
      fg = "#7aa2f7";
      bold = true;
    };
    # Button text: soft foreground
    AlphaButton = {
      fg = "#c0caf5";
    };
    # Button shortcut key: orange accent
    AlphaButtonShortcut = {
      fg = "#ff9e64";
      bold = true;
      italic = true;
    };
    # Footer: muted comment color
    AlphaFooter = {
      fg = "#565f89";
      italic = true;
    };
  };
}
