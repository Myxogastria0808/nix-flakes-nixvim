# Comment Format: Plugin Block

Place just inside the top-level `{`, immediately before the plugin's option block.

## Format (no keymaps)

```nix
  # plugin-name
  # reference: https://github.com/owner/repo
  #
  # What the plugin does in this configuration.
```

## Format (with keymaps)

```nix
  # plugin-name
  # reference: https://github.com/owner/repo
  #
  # What the plugin does in this configuration.
  #
  # Keymaps:
  # <leader>e : toggle file tree (Normal)
  # <C-n>     : select next item (Insert)
  # <CR>      : confirm selection (Insert)
```

Keymap line format: `  # <keys> : description (Mode)` — align `:` across all lines in the block.

## Examples

```nix
  # neo-tree.nvim
  # reference: https://github.com/nvim-neo-tree/neo-tree.nvim
  #
  # File explorer tree shown on the left side of the editor.
  #
  # Keymaps:
  # <leader>e : toggle file tree (Normal)
```

```nix
  # nvim-cmp
  # reference: https://github.com/hrsh7th/nvim-cmp
  #
  # Completion engine with LSP, buffer word, and file path sources.
  #
  # Keymaps:
  # <C-n> : select next item (Insert)
  # <C-p> : select previous item (Insert)
  # <CR>  : confirm selected item, or fall through to newline if none selected (Insert)
```

