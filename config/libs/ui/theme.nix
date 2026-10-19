# theme.nix — Colorscheme using tokyonight.nvim.
# Style: night (the darkest variant).
{
  # tokyonight.nvim
  # reference: https://github.com/folke/tokyonight.nvim
  #
  # Colorscheme for the editor UI and syntax highlighting.
  colorschemes.tokyonight = {
    enable = true;
    # available styles: moon | storm | night | day
    # night is the darkest variant
    settings.style = "night";
  };
}

