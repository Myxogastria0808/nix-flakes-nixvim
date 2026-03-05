{
  # nvim-lspconfig (via NixVim)
  # reference: https://github.com/neovim/nvim-lspconfig
  #
  # Configures language servers for LSP features (diagnostics, go-to-definition, etc.).
  # Enabled servers:
  #   nil_ls   : Nix           (reference: https://github.com/oxalica/nil)
  #   marksman : Markdown      (reference: https://github.com/artempyanykh/marksman)
  #   bashls   : shell scripts (reference: https://github.com/bash-lsp/bash-language-server)
  plugins.lsp = {
    enable = true;
    servers = {
      # Nix language server
      nil_ls.enable = true;
      # Markdown language server
      marksman.enable = true;
      # shell script language server (sh, bash, zsh)
      bashls = {
        enable = true;
        filetypes = [
          "sh"
          "bash"
          "zsh"
        ];
      };
    };
  };

  # lean.nvim
  # reference: https://github.com/Julian/lean.nvim
  #
  # Provides Lean 4 language support with an interactive infoview panel.
  # <LocalLeader> is set to Space.
  #
  # Keymaps in Lean files:
  # <LocalLeader>i         : toggle the infoview open or closed
  # <LocalLeader>p         : pause the current infoview
  # <LocalLeader>r         : restart the Lean server for the current file
  # <LocalLeader>v         : interactively configure infoview view options
  # <LocalLeader>x         : place an infoview pin
  # <LocalLeader>c         : clear all current infoview pins
  # <LocalLeader>dx        : place an infoview diff pin
  # <LocalLeader>dc        : clear current infoview diff pin
  # <LocalLeader>dd        : toggle auto diff pin mode
  # <LocalLeader>dt        : toggle auto diff pin mode without clearing diff pin
  # <LocalLeader><Tab>     : jump into the infoview window
  # <LocalLeader>\         : show what abbreviation produces the symbol under the cursor
  #
  # Keymaps in Infoview windows:
  # <CR> / K               : click a widget or interactive area
  # gK                     : select a widget ("shift+click")
  # <Tab> / J              : jump into a tooltip
  # <Shift-Tab>            : jump out of a tooltip
  # <Esc> / C              : clear all open tooltips
  # gd                     : go-to-definition
  # gD                     : go-to-declaration
  # gy                     : go-to-type
  # <LocalLeader><Tab>     : jump to the lean file from the infoview
  plugins.lean = {
    enable = true;
    settings = {
      # infoview panel settings
      infoview = {
        height = 10;
        orientation = "horizontal";
        horizontal_position = "bottom";
        indicators = "always";
      };
      # enable the keymaps listed in the header above
      mappings = true;
    };
  };
}
