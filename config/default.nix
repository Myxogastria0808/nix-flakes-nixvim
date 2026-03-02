{
  imports = [
    ./plugins/tree.nix
    ./plugins/format.nix
    ./plugins/lsp.nix
    ./plugins/gitsigns.nix
    ./plugins/lualine.nix
    ./keymaps.nix
  ];

  colorschemes.tokyonight.enable = true;

  opts = {
    number = true;
    fillchars.eob = " ";
  };
}
