---
name: update-skills
description: Verify and update all SKILL.md files under .claude/skills/ so they accurately reflect the actual Nix configuration and current repository structure.
disable-model-invocation: true
---

# Update All SKILL.md Files

## Step 1: Read all Nix files and all SKILL.md files

**CRITICAL: Read ALL files before making any edits**

You must read every file listed below before editing anything. Do not start editing until all reads are complete.

1. Use Glob to enumerate all `.nix` files under `config/` and Read each one.
2. Use Glob to enumerate all `SKILL.md` files under `.claude/skills/` and Read each one.
3. Read all files under `.claude/skills/update-nix-description/references/` as well.

## Step 2: Verify each SKILL.md against the actual Nix config

For each SKILL.md, check the following against the actual `.nix` files:

1. **Plugin names, keybindings, file paths, LSP servers** — any specific values mentioned in the skill must match what is actually present in the Nix config.
2. **`description` frontmatter** — must accurately describe what the skill does.
3. **Referenced file paths** — any paths cited in the skill (e.g. `config/default.nix`, `references/*.md`) must actually exist. Verify with Glob or Grep.
4. **Language** — the SKILL.md body must be written entirely in English. Flag any Japanese text as a discrepancy.
5. **Constraints section** — must exist and correctly describe the skill's constraints.

## Step 3: Update each SKILL.md

Based on the verification results, fix any content that diverges from the actual Nix config:

- Correct plugin names, keybindings, or file paths that differ from the actual config.
- Rewrite the `description` frontmatter if it is inaccurate.
- Replace any Japanese text in the body with English.
- Add a Constraints section if missing.

Rules for editing:
- Do not change the skill's workflow logic — only fix factual accuracy against the Nix config.
- Do not remove existing content that is correct.
- Every edited file must end with exactly one trailing newline.

## Step 4: Display summary in Japanese

After all edits are complete, **always** output a summary **in Japanese** covering:

- List of edited files (file path and a brief description of what changed)
- Files left unchanged and the reason why
- Discrepancies found between skills and the actual Nix config

Use Markdown bullet lists or tables for the output. Omitting the summary is not allowed.

---

## Constraints

- **Do not start editing until all Nix files and all SKILL.md files have been read.**
- Write all SKILL.md bodies in English only.
- Do not change skill workflow logic — fix factual accuracy against the Nix config only.
- Do not remove existing correct content.
- Every edited file must end with exactly one trailing newline (per CLAUDE.md File Editing Rules).
