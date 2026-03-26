# Comment Format: File Header

Place at the very top of the file, before the opening `{`.

## Format

```nix
# filename.nix — One-line summary of the file's purpose.
# Second line with additional detail if needed.
# Third line for more detail (highlight groups, key behaviours, etc.).
```

## Examples

```nix
# config/default.nix — Root NixVim module.
# Imports all sub-modules from config/libs/ organised into three categories:
#   ui/       : visual and interface plugins
#   language/ : LSP servers, formatting, treesitter
#   action/   : editing workflow plugins and keymaps
```

```nix
# dashboard.nix — Startup screen using alpha-nvim.
# Shows a geometric ASCII art logo and the current Neovim version.
# Custom highlight groups: AlphaLogo (soft purple, bold) and AlphaFooter (muted, italic).
```
