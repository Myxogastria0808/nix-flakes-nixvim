---
name: check-keymap
description: Check whether a specific keybinding is already in use across all config/**/*.nix files, including implicit plugin defaults and Neovim built-ins not exposed in Nix.
disable-model-invocation: true
---

# Check Keybinding Conflict

## Step 1: Validate argument

If `$ARGUMENTS` is empty, use AskUserQuestion to ask the user which key to check (e.g. `<A-x>`, `<C-s>`, `<leader>e`), then stop.

## Step 2: Search all config files for the key

Use the Grep tool to search `config/` recursively in all `.nix` files:

1. Search for the exact key string from `$ARGUMENTS` (literal match) to find explicit bindings.
2. Search for `key\s*=` to collect all existing explicit bindings for context.

Read any matching lines to understand the purpose of each binding.

## Step 3: Assess implicit and undisclosed bindings

Not all active keybindings are written in the Nix config. You must also consider:

### 3a. Plugin default keymaps

Read `config/default.nix` to identify which plugins are enabled in this repo. For each enabled plugin, use your knowledge to determine whether it registers any default keymaps that match `$ARGUMENTS` and are **not overridden or disabled** in the Nix config. If a match is found, flag it as potentially in use.

### 3b. Neovim built-in keymaps

Neovim ships with many built-in Normal/Insert/Visual/Operator-pending mappings. If `$ARGUMENTS` matches a well-known built-in (e.g. `K`, `gd`, `gg`, `G`, `dd`, `yy`, `p`, `u`, `<C-r>`, `<C-w>*`, `ZZ`, etc.), report it as a built-in — even if it has been remapped by an LSP or plugin in this config.

## Step 4: Report results in Japanese

Output a structured Markdown report **entirely in Japanese**.

### Sections to include:

#### 1. Explicit Nix bindings (from `config/`)

| File | Line | Purpose |
| ---- | ---- | ------- |

If none found, write: _No explicit binding found in config/._

#### 2. Implicit plugin defaults

List any plugin default keymaps that match `$ARGUMENTS` and are not overridden in the Nix config:

| Plugin | Default keymap | Scope / condition | Notes |
| ------ | -------------- | ----------------- | ----- |

If none found, write: _No known plugin defaults conflict with this key._

#### 3. Neovim built-ins

State whether `$ARGUMENTS` overlaps with a Neovim built-in, and if so what it does by default.

If none found, write: _No Neovim built-in uses this key._

#### 4. Verdict

- **Conflict** — if any of the three sources above returned a hit: state clearly that the key is already in use and summarize where.
- **Clear** — if all three sources returned nothing: state that the key appears to be available, and show a reference table of all existing explicit bindings that share the same modifier for situational awareness:

  | Key | File | Purpose |
  | --- | ---- | ------- |

#### 5. Honesty note

If your knowledge of a plugin's defaults is uncertain, explicitly say so rather than silently omitting it. For example: _"neoscroll default mappings are not well-documented in my training data — manual verification recommended."_

---

## Constraints

- Do not edit any files — this skill is read-only.
- Write the entire report in Japanese.
- Include file paths relative to the repository root.
- Never suppress uncertain information — flag it explicitly instead.

