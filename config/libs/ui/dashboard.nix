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
        # Top half of the snowflake (NixOS darker blue #5277C3)
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
        ];
        opts = {
          position = "center";
          hl = "AlphaNixBlue";
        };
      }
      {
        # Bottom half of the snowflake (NixOS lighter blue #7EBAE4)
        type = "text";
        val = [
          "▜██████████▛                  ▟███████████▛  "
          "         ▟███▖               ▟███▛           "
          "          ▟███▛              ▜███▛           "
          "          ▝████▙              ▜██▛           "
          "           ▝████▙            ▟███▙           "
          "    ▟███████████████████▙ ▜███▙              "
          "   ▟█████████████████████▙ ▜███▙             "
          "        ▜██████▛  ▟██████▙                   "
          "         ▜███▛    ▟████▛                     "
          "          ▀▀▀      ▀▀▀                       "
        ];
        opts = {
          position = "center";
          hl = "AlphaNixLightBlue";
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

  # Highlight groups for the dashboard using NixOS official brand colors.
  highlight = {
    # Top half: NixOS darker blue (#5277C3)
    AlphaNixBlue = {
      fg = "#5277c3";
      bold = true;
    };
    # Bottom half: NixOS lighter blue (#7EBAE4)
    AlphaNixLightBlue = {
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
