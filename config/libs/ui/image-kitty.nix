# image-kitty.nix — Auto-preview images as real per-pixel graphics via
# image.nvim's Kitty Graphics Protocol backend.
# Used by the `kitty` package (config/kitty.nix), which targets a terminal
# already known to speak the protocol (kitty, WezTerm, ghostty) — so unlike
# image-chafa.nix (used by the `default` package instead), there's no
# runtime terminal-capability check here: this whole package is that check,
# made once at build time by picking which one to run.
#
# Covers both opening an image file directly (hijack_file_patterns) and
# every image.nvim integration — Markdown, Typst, Neorg, AsciiDoc/reST
# ("syslang"), HTML, and CSS image references rendered inline, in the same
# buffer, at the referencing line (no floating window there either).
{ ... }:
{
  # image.nvim
  # reference: https://github.com/3rd/image.nvim
  #
  # Renders images as real per-pixel graphics via the Kitty Graphics Protocol backend.
  plugins.image = {
    enable = true;
    settings = {
      backend = "kitty";
      # image.nvim defaults to shelling out to the ImageMagick CLI
      # (`magick`/`convert`) to decode/resize images. Use the FFI-based
      # `magick` luarocks binding instead — nixpkgs' image-nvim package
      # already bundles it (linked against ImageMagick), so no extra
      # package or PATH entry is needed, and it avoids a subprocess per
      # image.
      processor = "magick_rock";
      integrations = {
        markdown.enabled = true;
        typst.enabled = true;
        neorg.enabled = true;
        syslang.enabled = true;
        html.enabled = true;
        css.enabled = true;
      };
      hijack_file_patterns = [
        "*.avif"
        "*.gif"
        "*.jpg"
        "*.jpeg"
        "*.jxl"
        "*.png"
        "*.qoi"
        "*.svg"
        "*.tif"
        "*.tiff"
        "*.webp"
        "*.xwd"
      ];
    };
  };
}

