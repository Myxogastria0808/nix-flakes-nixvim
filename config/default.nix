# config/default.nix — Root NixVim module for the `default` package: works
# in any terminal. Image previews render as chafa character art (see
# libs/ui/image-chafa.nix). For real per-pixel image previews on a
# terminal that speaks the Kitty Graphics Protocol (kitty, WezTerm,
# ghostty), build the `kitty` package instead (config/kitty.nix) — it's the
# same config plus libs/ui/image-kitty.nix in place of image-chafa.nix.
{
  imports = [
    ./base.nix
    ./libs/ui/image-chafa.nix
  ];
}

