{
  imports = [
    ./plugins/tree.nix
    ./plugins/format.nix
    ./plugins/lsp.nix
    ./plugins/gitsigns.nix
    ./plugins/lualine.nix
    ./plugins/copilot.nix
    ./plugins/tab.nix
    ./plugins/utils.nix
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

  globals = {
    # set <leader> to space
    mapleader = " ";
    # set <LocalLeader> to space
    maplocalleader = " ";
  };

  opts = {
    # show line numbers
    number = true;
    # hide ~ at the end of buffer
    fillchars.eob = " ";
  };
}
