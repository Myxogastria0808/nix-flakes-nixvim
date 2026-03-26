---
name: update-nix-description
description: Update all Nix file comments, README.md, and CLAUDE.md to accurately reflect the actual Nix configuration.
disable-model-invocation: true
---

# Update All Nix file comments, README.md and CLAUDE.md

## Step 1: Read All Nix files, README.md and CLAUDE.md

**CRITICAL: Read ALL Nix files before making any edits**

You must read ALL Nix files before editing anything. Do not start editing until all reads are complete.

## Step 2: Add/update comments in every .nix file

**Before writing any comments, read all files in the `references/` directory to get the exact format specs.**

For each `.nix` file, add or update English comments so they accurately describe the actual configuration:

- **File header comment**: Add a `#` comment at the very top (before any `{`) briefly stating the file's purpose and what plugins/features it configures.
- **Section comments**: Add `#` comments before each major configuration block explaining what it does, referencing actual option values, keybindings, and plugin names as they appear in the code.
- **Inline comments**: Add short inline comments for non-obvious settings.
- Comments must match the actual code — do not describe options that are not present.
- Follow the existing comment style (`# ...`).
- Do not add comments that simply restate the option name.
- **Comment formats**: Follow the exact conventions in the `references/` directory:
  - `references/file-header.md` — file header format
  - `references/plugin-block.md` — plugin block + keymaps section format
  - `references/keymap-item.md` — individual keymap item format
  - `references/inline-setting.md` — inline single-option comment format

## Step 3: Update README.md

Update `README.md` so it accurately reflects the current Nix configuration:

- **Module structure table**: Ensure each row matches the actual file contents (plugin names, features, keybindings).
- **Keybindings reference**: Ensure every listed keybinding matches what is actually configured in the `.nix` files. Add missing bindings; remove or correct outdated ones.
- **Language support matrix**: Ensure the list of LSP servers, formatters, and treesitter parsers matches the actual configuration.
- Preserve the existing document structure and formatting style.

## Step 4: Update CLAUDE.md

Update `CLAUDE.md` so it accurately reflects the current Nix configuration:

- **Module structure tables** (`ui/`, `language/`, `action/`): Ensure each row's "Contents" column accurately describes the actual file.
- Do not change the project instructions, commands, architecture sections, or rules (File Editing Rules, Keybinding Rules) unless their factual content is wrong.

---

## Constraints

- **Do not start editing until all files have been read.**
- Every edited file must end with exactly one trailing newline (enforce the rule from CLAUDE.md's "File Editing Rules" section).
- Use English for all comments added to `.nix` files.
- Do not remove existing comments unless they are factually incorrect.
- Do not change any Nix option values — only add or modify comments and documentation.
- After all edits, run `nix build .#default` to verify the build still succeeds.

