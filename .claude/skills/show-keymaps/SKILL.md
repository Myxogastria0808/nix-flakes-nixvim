---
name: show-keymaps
description: Collect and display all keymaps defined across config/**/*.nix as a structured Japanese report.
disable-model-invocation: true
---

# Show All Keymaps

## Step 1: Read all config files

**CRITICAL: Read ALL files before producing any output**

1. Use Glob to enumerate all `.nix` files under `config/`.
2. Use Grep to search `key\s*=` recursively in `config/` to identify files that contain keymaps.
3. Read every identified file. Do not begin output until all reads are complete.

## Step 2: Extract and organize keymaps

From each file, extract the following fields:

- **`key`** — keybinding string (e.g. `<C-s>`, `<leader>e`)
- **`mode`** — applicable mode(s) (`n` / `i` / `v` / `t`, etc.)
- **`action`** or **`action.__raw`** — the operation executed
- **`options.desc`** — description text (if present)
- **source file path** — relative to the repository root

Additionally, read `config/default.nix` to identify which plugins are enabled, then use your knowledge to supplement with plugin-registered default keymaps that are **not overridden** in the Nix config (e.g. lspsaga, neo-tree, nvim-cmp, copilot).

## Step 3: Report results in Japanese

Output a structured Markdown report **entirely in Japanese**.

### Sections to include:

#### Explicit keymaps (from `config/`)

Group by source file. For each file that contains keymaps, use the file path as a heading and display a table:

| Key | Mode | Purpose | Notes |
| --- | ---- | ------- | ----- |

Skip files that contain no keymaps.

#### Plugin default keymaps

List plugin default keymaps that are active and not overridden in the Nix config:

| Plugin | Key | Mode | Purpose |
| ------ | --- | ---- | ------- |

If knowledge of a plugin's defaults is uncertain, explicitly note it rather than omitting it silently.

#### Summary

- Total explicit keymaps: N
- Supplemented plugin defaults: N

---

## Constraints

- Do not edit any files — this skill is read-only.
- Write the entire report in Japanese.
- Include file paths relative to the repository root.
- **Do not begin output until all files have been read.**
- Never suppress uncertain plugin information — flag it explicitly instead.

