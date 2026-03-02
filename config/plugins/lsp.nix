{
  plugins = {
    lsp = {
      enable = true;
      servers = {
        # nix
        nil_ls = {
          enable = true;
          settings.nix.flake.autoArchive = true;
        };
        # markdown
        marksman.enable = true;
      };
    };
    # lean
    lean = {
      enable = true;
      settings = {
        # infoview (proof state window) settings
        infoview.width = 0.2;
        # enable recommended keymaps in Lean buffers
        # <leader>i : toggle infoview open/close
        # <leader>p : pause/unpause infoview updates
        # <leader>x : add pin at current cursor position
        # <leader>c : clear all pins
        # <leader>d : set diff pin (compare two proof states)
        # <leader>t : replace "sorry" with suggestion (Try this)
        mappings = true;
      };
    };
  };
}
