{
  plugins = {
    lsp = {
      enable = true;
      servers = {
        # nix
        # reference: https://github.com/oxalica/nil
        nil_ls.enable = true;
        # markdown
        # reference: https://github.com/artempyanykh/marksman
        marksman.enable = true;
      };
    };
    # lean
    # reference: https://github.com/Julian/lean.nvim
    lean = {
      enable = true;
      settings = {
        # infoview (proof state window) settings
        infoview = {
          height = 10;
          orientation = "horizontal";
          horizontal_position = "bottom";
          indicators = "always";
        };
        # enable recommended keymaps in lean buffers
        # <LocalLeader> was defined as `Space`
        #
        # In Lean Files:
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
        # In Infoview Windows:
        # <CR> / K               : click a widget or interactive area
        # gK                     : "select" a widget ("shift+click")
        # <Tab> / J              : jump into a tooltip
        # <Shift-Tab>            : jump out of a tooltip
        # <Esc> / C              : clear all open tooltips
        # gd                     : go-to-definition
        # gD                     : go-to-declaration
        # gy                     : go-to-type
        # <LocalLeader><Tab>     : jump to the lean file from the infoview
        mappings = true;
      };
    };
  };
}
