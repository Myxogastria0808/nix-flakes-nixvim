{
  imports = [
    ./plugins/tree.nix
    ./plugins/format.nix
    ./plugins/lsp.nix
    ./plugins/gitsigns.nix
    ./plugins/bar.nix
    ./plugins/copilot.nix
    ./plugins/tab.nix
    ./plugins/ui.nix
    ./plugins/action.nix
    ./keymaps.nix
  ];

  # tokyonight color scheme
  # reference: https://github.com/folke/tokyonight.nvim
  colorschemes.tokyonight = {
    enable = true;
    # available styles: moon | storm | night | day
    # night is the darkest variant
    settings.style = "night";
  };

  opts = {
    # show line numbers
    number = true;
    # hide ~ at the end of buffer
    fillchars.eob = " ";
  };
}
