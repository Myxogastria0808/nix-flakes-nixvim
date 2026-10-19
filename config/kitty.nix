# config/kitty.nix — Root NixVim module for the `kitty` package: for
# terminals that speak the Kitty Graphics Protocol (kitty, WezTerm,
# ghostty). Image previews render as real per-pixel images via image.nvim
# (see libs/ui/image-kitty.nix) instead of the `default` package's chafa
# character art — same config otherwise.
{
  imports = [
    ./base.nix
    ./libs/ui/image-kitty.nix
  ];
}

