# theme.nix — Colorscheme using catppuccin.
# Flavour: mocha (the darkest variant).
{
  # catppuccin
  # reference: https://github.com/catppuccin/nvim
  colorschemes.catppuccin = {
    enable = true;
    # available flavours: latte | frappe | macchiato | mocha
    # mocha is the darkest variant
    settings.flavour = "mocha";
  };
}

