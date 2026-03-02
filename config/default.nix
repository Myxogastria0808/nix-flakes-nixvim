{
  imports = [
    ./plugins/tree.nix
    ./plugins/format.nix
    ./plugins/lsp.nix
    ./plugins/gitsigns.nix
    ./keymaps.nix
  ];

  opts = {
    number = true;
    fillchars.eob = " ";
  };
}
