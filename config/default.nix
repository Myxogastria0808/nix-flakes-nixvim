{
  imports = [
    ./plugins/tree.nix
    ./plugins/format.nix
    ./plugins/lsp.nix
    ./plugins/gitsigns.nix
    ./plugins/lualine.nix
    ./plugins/copilot.nix
    ./keymaps.nix
  ];

  # set color theme
  # theme: tokyonight, night
  colorschemes.tokyonight = {
    enable = true;
    # style has `moon`, `storm`, `night` and `day`.
    # darker variant is night.
    settings.style = "night";
  };

  opts = {
    # show numer of lines
    number = true;
    # hide `~` at the end of buffer
    fillchars.eob = " ";
  };
}
