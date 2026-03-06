{
  # alpha-nvim
  # reference: https://github.com/goolord/alpha-nvim
  #
  # Displays a start screen with the Nix snowflake logo and version when opened
  # without file arguments.
  #
  # NixOS logo © NixOS Project contributors
  # Licensed under CC BY 4.0 — https://creativecommons.org/licenses/by/4.0/
  # Source: https://github.com/NixOS/branding
  # The ASCII art below is a derivative work of the NixOS snowflake logo.
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
          "          ▗▄▄▄       ▗▄▄▄▄    ▄▄▄▖          "
          "          ▜███▙       ▜███▙  ▟███▛           "
          "           ▜███▙       ▜███▙▟███▛            "
          "            ▜███▙       ▜██████▛             "
          "     ▟█████████████████▙ ▜████▛     ▟▙       "
          "    ▟███████████████████▙ ▜███▙    ▟██▙      "
          "           ▄▄▄▄▖           ▜███▙  ▟███▛      "
          "          ▟███▛             ▜██▛ ▟███▛       "
          "         ▟███▛               ▜▛ ▟███▛        "
          "▟███████████▛                  ▟██████████▙  "
          "▜██████████▛                  ▟███████████▛  "
          "         ▟███▖               ▟███▛           "
          "          ▟███▛              ▜███▛           "
          "          ▝████▙              ▜██▛           "
          "           ▝████▙             ▟▛             "
          "    ▟███████████████████▙ ▜███▙              "
          "   ▟█████████████████████▙ ▜███▙             "
          "        ▜██████▛▀▜██████▛                    "
          "         ▜███▛    ▜███▛                      "
          "          ▀▀▀      ▀▀▀                       "
        ];
        opts = {
          position = "center";
          hl = "AlphaNixHeader";
        };
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
    # Header: NixOS light blue (#7EBAE4)
    AlphaNixHeader = {
      fg = "#7ebae4";
      bold = true;
    };
    # Footer: muted comment color
    AlphaFooter = {
      fg = "#565f89";
      italic = true;
    };
  };
}
