# theme.nix — Colorscheme using tokyonight.nvim.
# Style: night (the darkest variant).
{
  # tokyonight.nvim
  # reference: https://github.com/folke/tokyonight.nvim
  colorschemes.tokyonight = {
    enable = true;
    # available styles: moon | storm | night | day
    # night is the darkest variant
    settings.style = "night";
  };
}

