# Comment Format: Individual Keymap Item

Place directly above each keymap list item (`keymaps = [...]`) or plugin-internal keymap
option assignment (e.g. `next = "<A-]>"`), in any `.nix` file.

## Format

```nix
  # Human-readable description of what the keymap does.
  # keybind: Key combination (e.g. Ctrl + S, Alt + ], Space + e)
```

Two lines, always together: description line first, `# keybind:` line second.

## Examples

```nix
  # Save the current file.
  # keybind: Ctrl + S
```

```nix
  # Accept copilot suggestion with Tab, fallback to normal Tab.
  # keybind: Tab
```

```nix
  # keybind: Alt + ]
  next = "<A-]>";
```
